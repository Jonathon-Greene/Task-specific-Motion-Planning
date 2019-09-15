%% Data Generation 3
% Learn the model

clear
clc

% Load demo to learn
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_results.mat');

% Set Save Parameters
filename_output = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_ELMoutput.mat';
filename_model = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12_ELMmodel.mat';

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

% Concatenate Data
for i =1:size(Results,1)
test_train(i,1) = [ [Results{i,1,5}]' ]; %result
test_train(i,2:5) = [ rotm2quat(Results{i,1,1}(1:3,1:3)) ]; %quaternions
test_train(i,6:7) = [ [Results{i,1,1}(1,4),Results{i,1,1}(2,4)] ]; %xy pos
end

% Classify as 1 (success) or 0 (fail). Remove Dexterous Failures
j = 1;
while j < size(test_train,1)+1
    
    if test_train(j,1) == 2 || test_train(j,1) == 3
    test_train(j,1) = 0;
    j = j+1;
    elseif test_train(j,1) == 4
    test_train(j,:) = [];
    elseif test_train(j,1) == 1
    j = j + 1;
    end
    
end


% Shuffle Data
test_train_shuffled = test_train(randperm(size(test_train,1)),:);

% Split into testing and training sets
p = .8; % percent of data for training
ntr = round(p*size(test_train,1));
train = test_train_shuffled(1:ntr,:);
test = test_train_shuffled(ntr+1:end,:);

%% Learn Data
[TrainingTime,TrainingAccuracy]...
    = elm_train_m(train,1,10000,'sig',filename_model);
[TestingTime, TestingAccuracy] = elm_predict_m(test, filename_output, filename_model);

