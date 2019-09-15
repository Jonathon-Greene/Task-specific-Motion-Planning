%% Data Generation 5
% Create heatmap of learned data
% Heatmap will be in the xy plane. The color of each xy point will vary
% according to the average predicted ability of the demonstration over all
% rotations


clear
clc

demo1a = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_1b_z12';
demo1b{1} = '_z12';
demo1b{2} = '_z0';
demo1b{3} = '';
demo1c = '_Temp_ELM_highres.mat';

demo2a = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_17b_z12';

% demo3a = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_9b_z12';

% demo4a = 'C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_2b';


%for k = 1:3
k = 3;    
    if k ==1
        z = .012;
    elseif k ==2
        z = 0;
    else
        z = .006;
    end
    
    j = 1;
    % Load learned data demo 1
    Temp_ELM_demo = load([demo1a,demo1b{k},demo1c]);
    Temp_ELM_c{j} = struct2array(Temp_ELM_demo); % Convert from struct to array
    j = j+1;

    % Load learned data demo 2
    Temp_ELM_demo = load([demo2a,demo1b{k},demo1c]);
    Temp_ELM_c{j} = struct2array(Temp_ELM_demo); % Convert from struct to array
    j = j+1;

%     % Load learned data demo 3
%     Temp_ELM_demo = load([demo3a,demo1b{k},demo1c]);
%     Temp_ELM_c{j} = struct2array(Temp_ELM_demo); % Convert from struct to array
%     j = j+1;

    
    % Combine results
    output_p = zeros(size(Temp_ELM_c{1},1),1);
    for i = 1:size(Temp_ELM_c,2)
        output_p = output_p + Temp_ELM_c{i}(:,1);
    end

    for i = 1:size(output_p,1)
        if output_p(i) > 1
            output_p(i) = 1;
        end
    end

    % Compile final combined results matrix
    Temp_ELM = [output_p Temp_ELM_c{1}(:,2:end)];

    % Compute percent of success at each xy and rotation
    HM = ComputeSuccess(Temp_ELM);

    %% Plot heatmap
    HM = [HM zeros(size(HM,1),3)];
    
    % Add color rbg values to HM matrix
    for n = 1:size(HM,1)
        HM(n,6:8) = colorrbg(HM(n,5));
    end
    
    % Plot first point
    scatter3(HM(1,1),HM(1,2),z,'.','MarkerFaceColor',[HM(1,6:8)],'MarkerEdgeColor',[HM(1,6:8)])
    hold on

    % Plot additional points
    for p = 1:size(HM,1)
    scatter3(HM(p,1),HM(p,2),z,'.','MarkerFaceColor',[HM(p,6:8)],'MarkerEdgeColor',[HM(p,6:8)])
    end
    view(30,40)

%end

%% Save HM Matrix

% Need to manually edit this
save('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_1b17b_z12_HM.mat','HM')
