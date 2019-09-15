%% Visualize Results
clear
clc
load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\Results_b\traj_data_2b_results.mat')

n = 7 %number of unique orientations
% need to pull number of unique orientations automatically next time


%% Plot Orientations

%plot first orientation
for j = 1:n
figure 
plot3(Results{1,1,1}(1,4),Results{1,1,1}(2,4),Results{1,1,1}(3,4),'o')
hold on

    for i = j:n:size(Temp,3)
        if Results{i,1,5} == 1 % If success
        plot3(Results{i,1,1}(1,4),Results{i,1,1}(2,4),Results{i,1,1}(3,4),'o',...
            'Color','g')
        elseif Results{i,1,5} == 2 || Results{i,1,5} == 3 %If failure
        plot3(Results{i,1,1}(1,4),Results{i,1,1}(2,4),Results{i,1,1}(3,4),'o',...
            'Color','r')
        elseif Results{i,1,5} == 4 %If dextrous failure
        plot3(Results{i,1,1}(1,4),Results{i,1,1}(2,4),Results{i,1,1}(3,4),'o',...
            'Color','y')
        end
    end
    
hold off
end

%plot the demonstration 1
%load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\optimalcelldemo2.mat');
%theta = theta1';
[~, g_st1, ~] = denoising(theta1);
for j = 1:size(g_st1,3) 
plot3(g_st1(1,4,j),g_st1(2,4,j),g_st1(3,4,j),'x',...
        'Color','b')
end
% 
% 
% % Plot another demonstration in cyan circles
% load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\optimalcelldemo3.mat');
% theta1 = degtorad(optimalcelldemo3)';
% [~, g_st2, ~] = denoising(theta1);
% %plot the demonstration
% for j = 1:size(g_st2,3) 
% plot3(g_st2(1,4,j),g_st2(2,4,j),g_st2(3,4,j),'o',...
%         'Color','c')
% end
% 
% % Plot another demonstration in magenta points
% load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\optimalcelldemo.mat')
% theta1 = optimalcelldemo';
% [~, g_st3, ~] = denoising(theta1);
% %plot the demonstration
% for j = 1:size(g_st3,3) 
% plot3(g_st3(1,4,j),g_st3(2,4,j),g_st3(3,4,j),'.',...
%         'Color','m')
% end

hold off


%% Plot Temp

plot3(Temp(1,4,i),Temp(2,4,i),Temp(3,4,i),'o')
hold on
%plot first orientation
for i = 1:n:size(Temp,3)
%     if Results{i,1,5} == 1 % If success
%     plot3(Temp(1,4,i),Temp(2,4,i),Temp(3,4,i),'o','Color','g')
%     else %If failure
    plot3(Temp(1,4,i),Temp(2,4,i),Temp(3,4,i),'o','Color','g')
%     end
end

%plot the demonstration 1
for j = 1:size(g_st1,3) 
plot3(g_st1(1,4,j),g_st1(2,4,j),g_st1(3,4,j),'x',...
        'Color','b')
end
hold off
