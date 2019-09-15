%% Data Generation 2
% Check each discrete point for motion path success or failure using
% motion planner

clear
clc

tic

%load discretized (temp) workspace
% This does not need to change unless the z height changes
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_1b_z11_temp.mat')

%load demo to test
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Examples_b\traj_data_1b.mat');
theta1 = theta';
[theta1, g_st1, DualQuaternion1] = denoising(theta1);

conv_status = true;
count_success = 0;
count_conv_failure = 0;
count_joint_failure = 0;
count_dex_failure = 0;

% Results Key
% Column 1: goal configuration
% Column 2: mindist
% Column 3: rot_met
% Column 4: Joint Angles
% Column 5: Convergence Status
    % Successfully Converges = 1
    % Does Not Converge = 2
    % Joint Limit Failure = 3
    % Dexterous Failure = 4

% Initialize results cell for speed
Results = cell(size(Temp,3),1,5); 


for i = 1:count_scenario
    [conv_status,counter,setofposes,joint_angles] = chap3_svm( Temp(:,:,i),theta1, g_st1, DualQuaternion1 );
    %Rotation matrix of generated point
    R_temp = Temp(1:3,1:3,i);
    if (conv_status == true) && (counter == 0) % Converges and does not voilate joint limits
        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );

        count_success = count_success + 1;
        fprintf('Percent Complete %0.2f\t',(i/count_scenario)*100)
        fprintf('Success %d\t',count_success)
        fprintf('Conv Fail %d\t',count_conv_failure)
        fprintf('Joint Fail %d\t',count_joint_failure)
        fprintf('Dex Fail %d\n',count_dex_failure)
         Results{i,1,1} = Temp(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 1;
        
    elseif (conv_status == false) && (counter == 0) % Does not converge and does not violate joint limits
        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );

        count_conv_failure = count_conv_failure + 1;
        fprintf('Percent Complete %0.2f\t',(i/count_scenario)*100)
        fprintf('Success %d\t',count_success)
        fprintf('Conv Fail %d\t',count_conv_failure)
        fprintf('Joint Fail %d\t',count_joint_failure)
        fprintf('Dex Fail %d\n',count_dex_failure)
         Results{i,1,1} = Temp(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 2;
      
    elseif (conv_status == true) && (counter > 0) % Converges and violates joint limits
        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );

        count_joint_failure = count_joint_failure + 1;
        fprintf('Percent Complete %0.2f\t',(i/count_scenario)*100)
        fprintf('Success %d\t',count_success)
        fprintf('Conv Fail %d\t',count_conv_failure)
        fprintf('Joint Fail %d\t',count_joint_failure)
        fprintf('Dex Fail %d\n',count_dex_failure)
         Results{i,1,1} = Temp(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 3;
        
        elseif (conv_status == false) && (counter < 0) % Given pose is out of workspace
        [dq] = MatrixToDQuaternion( Temp(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
        
        count_dex_failure = count_dex_failure + 1;
        fprintf('Percent Complete %0.2f\t',(i/count_scenario)*100)
        fprintf('Success %d\t',count_success)
        fprintf('Conv Fail %d\t',count_conv_failure)
        fprintf('Joint Fail %d\t',count_joint_failure)
        fprintf('Dex Fail %d\n',count_dex_failure)
         Results{i,1,1} = Temp(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 4;     
    end
    
end

disp('Number of successful scenarios:');
disp(count_success);
disp('Number of failed scenarios:');
disp(count_conv_failure + count_joint_failure + count_dex_failure);
disp('Number of dex failed scenarios:');
disp(count_dex_failure);

toc

save("C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_1b_z11_results.mat")