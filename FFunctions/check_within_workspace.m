% Given an end-effector pose wrt base frame of Baxter robot's left arm,
% the following code output if an inverse kinematics solution exists to
% that pose.

function[status] = check_within_workspace(g_pose)


ee_within_workspace(g_pose);

    % Function to check if an end-effector pose is in the workspace
    function[] = ee_within_workspace(gst_d)
        % DH parameters of left-arm of Baxter robot
        ak = [0.069 0 0.069 0 0.010 0 0];
        dk = [0.27035 0 0.36435 0 0.37429 0 0.2295 + 0.150];  % 0.150 is added for extendend-narrow gripper
        alp = pi*[-1/2 1/2 -1/2 1/2 -1/2 1/2 0];

        % Transformation of first arm joint to base frame
        bax_base = [0.7071   -0.7071         0    0.0640;
                    0.7071    0.7071         0    0.2590;
                         0         0    1.0000    0.1296;
                         0         0         0    1.0000];

        % Compute values of desired parameters
        ee_pose = gst_d(1:3,4);           % desired tool position
        TRz = gst_d(1:3,3);               % desired tool z axis
        wrist_base = ee_pose - TRz*dk(7); % desired wrist position (torso frame)
        L1 = sqrt(dk(3)^2 + ak(3)^2);
        L2 = sqrt(dk(5)^2 + ak(5)^2);

        % Describe range of theta1
        th1_max = 1.7016; th1_min = -1.7016; th1_res = 100;
        th1_range = linspace(th1_min, th1_max, th1_res);

        % Check for existence of an IK solution for any value of theta1
        ik_exists = false;
        for ang = th1_range
            frame1_wrt_base = bax_base * bax_tran(ak(1), dk(1), alp(1), ang, 1);
            wrist_position_wrt_frame1 = frame1_wrt_base(1:3,1:3)' * wrist_base - ...
                frame1_wrt_base(1:3,1:3)' * frame1_wrt_base(1:3,4);
            d = norm(wrist_position_wrt_frame1);
            if d < L1 + L2
                ik_exists = true;
                break;
            end
        end

        if ik_exists
            %fprintf("Given pose is within the workspace\n");
            status = 1;
        else
            %fprintf("Given pose is out of workspace\n");
            status = 2;
        end
    end

    % Computes local frame transforms of Baxter arm
    function[trans_mat] = bax_tran(a, d, alp, ang, i)
    if i == 2
        ang = ang + pi/2;
    end
    trans_mat = [cos(ang) -cos(alp)*sin(ang) sin(alp)*sin(ang)  a*cos(ang);
                 sin(ang) cos(alp)*cos(ang) -sin(alp)*cos(ang)  a*sin(ang);
                 0 sin(alp) cos(alp) d;
                 0 0 0 1];
    end
status;
end
