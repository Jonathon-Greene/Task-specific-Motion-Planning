%% Import examples
% Loads each example file, imports as array, saves as .mat file
% Imports only left arm joint angles S0, S1, E0, E1, W0, W1, W2
% Joint angles are in radians
% Does NOT denoise examples

clear
clc


location = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Examples_b';
dir=dir([location, '/*.txt']);

for i = 1:size(dir,1)
file = strcat(dir(i).folder,'\',dir(i).name);
theta = readtable(file);
theta = table2array(theta(:,2:8));

filename = string([file(1:end-4),'.mat']);
save(filename, 'theta')
end