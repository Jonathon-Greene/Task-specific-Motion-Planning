%% User Guided Motion Planning
% Jonathon Greene
% Riddhiman Laha
% Professor Chakraborty
% 8/13/2019
% Stony Brook University

clear
clc
close all;

%% Generate Discrete Workspace

n_Rz = 2; %number of discrete z rotation orientations
layers = 1; %number of z layers
delta_z = 0; %change in z height per layer
res = 400; %number of xy points in discrete workspace
z_min = -.0384; %height of workspace plane (meters)
T_discrete = discrete_ws(n_Rz, delta_z, layers, res, z_min);

%% Check Generated Data
 plot3(squeeze(T_discrete(1,4,:)),squeeze(T_discrete(2,4,:)),...
     squeeze(T_discrete(3,4,:)),'o','Color','r')
 hold on


%% Check the center of the demonstration against the generated data
% Load the demonstration
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\optimalcelldemo2.mat','theta1');
% Process the demonstration (convert to radians, denoise)
theta1 = degtorad(theta1);
[theta1, g_st1, DualQuaternion1] = denoising(theta1');

plot3(g_st1(1,4,end),g_st1(2,4,end),g_st1(3,4,end),'x','Color','g')
%% Test Demonstration over Discrete Workspace

% Test each point for convergence
conv_status = true;
count_success = 0;
count_failure = 0;
count_store1 = 1;
count_store2 = 1;
count_store3 = 1;

% Results Key
% Column 1: goal configuration
% Column 2: mindist
% Column 3: rot_met
% Column 4: Joint Angles
% Column 5: Convergence Status
    % Successfully Converges = 1
    % Does Not Converge = 2
    % Unsuccessful (reason?) = 3

% Initialize results cell for speed
Results = cell(size(T_discrete,3),1,5);    
    
for i = 1:size(T_discrete,3)
    
    waitbar(i/size(T_discrete,3))
    fprintf('Loop start\t\t')
    [conv_status,counter,joint_angles] = ...
        motionplan_check(T_discrete(:,:,i),theta1,g_st1,DualQuaternion1);
        
    % Successfully Converges
    if (conv_status == true) && (counter == 0)
        [dq] = MatrixToDQuaternion( T_discrete(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
         
         %fprintf(fileID1,'%f,%f\n', mindist,rot_met);
         %Results{i,1,1} = g_st1(:,:,i);
         Results{i,1,1} = T_discrete(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 1;
        Successful_Points(:,:,count_store1) = T_discrete(:,:,i);
        count_success = count_success + 1;
        count_store1 = count_store1 + 1;
    
    % Does Not Converge    
    elseif (conv_status == false) && (counter == 0)
        [dq] = MatrixToDQuaternion( T_discrete(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
        
         %fprintf(fileID2,'%f,%f\n', mindist,rot_met);
         %Results{i,1,1} = g_st1(:,:,i);
         Results{i,1,1} = T_discrete(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 2;
        NonConverging_Points(:,:,count_store2) = T_discrete(:,:,i); 
        count_failure = count_failure + 1;
        count_store2 = count_store2 + 1;
    
    % Unsuccessful (reason?)  
    elseif (conv_status == true) && (counter > 0)
        [dq] = MatrixToDQuaternion( T_discrete(:,:,i) );
         [ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
        
         %fprintf(fileID3,'%f,%f\n', mindist,rot_met);
         %Results{i,1,1} = g_st1(:,:,i);
         Results{i,1,1} = T_discrete(:,:,i);
         Results{i,1,2} = mindist;
         Results{i,1,3} = rot_met;
         Results{i,1,4} = joint_angles;
         Results{i,1,5} = 3;
        Unsuccessful_Points(:,:,count_store3) = T_discrete(:,:,i);
        count_failure = count_failure + 1;
        count_store3 = count_store3 + 1;
    end
        fprintf('Loop finish\n')

disp('Number of successful scenarios:');
disp(count_success);
disp('Number of failed scenarios:');
disp(count_failure);
end

disp('Number of successful scenarios:');
disp(count_success);
disp('Number of failed scenarios:');
disp(count_failure);

%% Plot Results in Baxter Workspace


load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results.mat')
plot3(squeeze(Results{1,1,1}(1,4,:)),squeeze(Results{1,1,1}(2,4,:)),...
     squeeze(Results{1,1,1}(3,4,:)),'o')
 hold on
for i = 2:size(Results,1) 
plot3(squeeze(Results{i,1,1}(1,4,:)),squeeze(Results{i,1,1}(2,4,:)),...
     squeeze(Results{i,1,1}(3,4,:)),'o')
end
%gui_robotic