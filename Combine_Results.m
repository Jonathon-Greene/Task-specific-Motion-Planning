%% Combine Results

clear
clc
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results2.mat');
g_st2 = g_st1;
Results2 = Results;
Temp2 = Temp;
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results.mat');

%Combine Results

Results12 = cell(size(Results,1), size(Results,2),size(Results,3));

% Results Key
% Column 1: goal configuration
% Column 2: mindist
% Column 3: rot_met
% Column 4: Joint Angles
% Column 5: Convergence Status
    % Successfully Converges = 1
    % Does Not Converge = 2
    % Unsuccessful (reason?) = 3