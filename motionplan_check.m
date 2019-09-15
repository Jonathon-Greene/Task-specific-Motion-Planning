function [conv_status,counter,joint_angles,new_pose] = motionplan_check( temp21,theta1, g_st1, DualQuaternion1 )

    q = MatrixToDQuaternion(temp21);

    % Compute the imitated motion from a new object configuration (q)
    [ new_pose, g_new] = Transformation1(q,DualQuaternion1'); 

    % Dual Quaternion interpolation
    % Parameters:
    % Variable i indexes into the imitated trajectory.
    i = 1; % Pose to start interpolation on imitated motion
    step = 1;
    sam =  25;   % Sample # dual quaternion to be taken from the interp result
    t = 0.01;   % Interpolation step
    m = 1;      % E in orient. b/t current pose and guide pose on imitated traj
    e = 1;      % E in position b/t current pose and guide pose on imitated traj
    mf = 1;     % E in orientat. b/t current pose and final pose.
    ef = 1;     % E in position between current pose and final pose.
    cc = 1000;  % Convergence Criteria, number of iterations allowed before 
                % non convergence is declared

    % Initialize
    conv_status = true;
    counter = 0;
    joint_angles(:,1) = theta1(:,1);
    initial_pose = forward_kinematics(theta1(:,1));
    position_tol = 1e-03;   
    orientation_tol = 1e-03; 
    length_trajectory = size(new_pose,1); 

    q1 = MatrixToDQuaternion(initial_pose);
    q2 = new_pose(i,:);
    [m, e] = convergence_test(q1,q2); %%% New Addition
    if(e > position_tol || m > orientation_tol) 
    % Condition if start point is not the initial point of imitating trajectory
        [G,result] = ScLERP( q1,q2,t); 
    end
    S(:,1) = [initial_pose(1:3,4,1)' q1(1,1:4)];
    k = 2;


    while ef(k-1) > position_tol || mf(k-1) > orientation_tol
        % Compute the desired configuration at any iteration
        if (e(k-1) > position_tol || m(k-1) > orientation_tol)
            g1(:,:,k) = G(:,:,sam);  
            % Desired config is a point from interp if imitated path not reached.
        else
            if (i < length_trajectory)
                g1(:,:,k) = g_new(:,:,i);  
                i = i+step;
                % Desired config is on the path if imitated path is reached and
                % all points on imitated path is not exhausted. 
                % Interpolation is not required.
            else
                g1(:,:,k) = g_new(:,:,end); 
                % Desired configuration is always the end point once all the 
                % points on the imitated path are exhausted.
            end
        end

        % Find the new current joint angles and the actual current
        % configuration based on previous actual configuration and current
        % desired configuration
        [J_st,S(:,k),joint_angles(:,k),g_final(:,:,k),q1(k,:)]...
            = redundancy_res_with_JLA(g1(:,:,k),S(:,k-1),joint_angles(:,k-1));

        % Compute the distance of current configuration to the next guide
        % configuration on imitated path
        [m(k),e(k)] = convergence_test(q1(k,:),q2);

        % Compute the distance of current configuration to goal configuration
        [mf(k),ef(k)] = convergence_test(q1(k,:),new_pose(end,:));

        % Compute interpolated path between current configuration and imitated
        % path when the current configuration is not on imitated path.
        if (e(k) > position_tol || m(k) > orientation_tol) 
            % Assignment of q2 for the next interpolation.
            if (i < length_trajectory)
                q2 = new_pose(i,:);  
                % Guide for interpolation from imitated path if imitated path
                % is not reached and all points on imitated path are not exhausted.
                i = i + step;
            else
                q2 = new_pose(end,:); 
                % The goal configuration is the guide once all the points on
                % the path are exhausted.
                sam= 20;
            end
            [G,result] = ScLERP( q1(k,:),q2,t);% Computing Interpolated path
            % from current configuration to a configuration on the imitated 
            % path. Interpolation is done only when the imitated path is not
            % reached.
        end
        if k > cc
            conv_status = false;
            break;
        end
        k = k+1;
    end

    [m(k),e(k)] = convergence_test(q1(k-1,:),new_pose(end,:)); 

    
    % Check for joint violations
    if (conv_status == true )

        if min(joint_angles(1,:))<-2.461
            counter = counter + 1;
        elseif max(joint_angles(1,:))> 0.89
                counter = counter + 1;
        end

        if min(joint_angles(2,:))<-2.147
            counter = counter + 1;
        elseif max(joint_angles(2,:))> 1.047
                counter = counter + 1;
        end
        
        if min(joint_angles(3,:))<-3.028
            counter = counter + 1;
        elseif max(joint_angles(3,:))> 3.028
                counter = counter + 1;
        end
        
        if min(joint_angles(4,:))<-0.052
            counter = counter + 1;
        elseif max(joint_angles(4,:))> 2.6180
                counter = counter + 1;
        end
        
        if min(joint_angles(5,:))<-3.059
            counter = counter + 1;
        elseif max(joint_angles(5,:))> 3.059
                counter = counter + 1;
        end
        
        if min(joint_angles(6,:))<-1.571
            counter = counter + 1;
        elseif max(joint_angles(6,:))> 2.094
                counter = counter + 1;
        end
        
        if min(joint_angles(7,:))<-3.059
            counter = counter + 1;
        elseif max(joint_angles(7,:)) > 3.059
                counter = counter + 1;
        end
        
    end

end    
