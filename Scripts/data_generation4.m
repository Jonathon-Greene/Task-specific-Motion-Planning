%% Data Generation 4
% Predict data over high resolution pseudo-continuous workspace


clear
clc


% Import high resolution discrete workspace (pseudo continuous workspace)
% This does not need to change unless z height is changing
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_1b_z12_highres.mat')

% Remove all unreachable configurations
Temp_status = zeros(size(Temp,3),1);
for i = 1:size(Temp,3)
status = check_within_workspace(Temp(:,:,i));
    if status == 2 % pose is beyond reachable workspace
        Temp_status(i) = 0;
    else %pose is within reachable workspace
        Temp_status(i) = 1;
    end
end
k = 1;
Temp_ELM = zeros(sum(Temp_status),7); %Temp_ELM is the psuedo continuous workspace
for j = 1:size(Temp_status,1)
    if Temp_status(j) == 1
        Temp_ELM(k,:) = [ 1,rotm2quat(Temp(1:3,1:3,j)),Temp(1,4,j),Temp(2,4,j) ];
            k = k + 1;
    else
    end
end

% Predict over this space
filename_model = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_ELMmodel.mat';
filename_output = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_ELMoutput_highres.mat';
[TestingTime, TestingAccuracy] = elm_predict_m(Temp_ELM, filename_output, filename_model);

% Add predicted labels to continuous space
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_ELMoutput_highres.mat')
Temp_ELM(:,1) = output';
save('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_Temp_ELM_highres.mat','Temp_ELM')
