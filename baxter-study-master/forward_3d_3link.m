clear; clc; close;

% setting Length of bar
%   z y
%   |/
%   \ x

%      o------o   
%      | L2    \  L3
%   L1 |        \
%     /|\        x end-effector
%    | o | origin
%     \_/

%      x
%      |
%   H3 |
%      o theta3 about y
%      |
%   H2 |
%      o theta2 about y
%      |
%   H1 |  
%     /|\        
%    | o | theta1 about z 
%     \_/


L1 = 10;
L2 = 10;
L3 = 20;
theta = [0 0 0];

% H1 rotate from origin with 
H0 = @(theta) [
    cosd(theta) -sind(theta) 0 0;
    sind(theta) cosd(theta)  0 0;
    0          0             1 0;
    0          0             0 1];
H1 = @(theta) [
    cosd(theta) -sind(theta) 0 0;
    sind(theta) cosd(theta)  0 0;
    0          0             1 0;
    0          0             0 1] * [
    eye(3) [0;0;L1]; [0 0 0 1]
    ];
% H1 rotate from origin with theta1
H2 = @(theta) [
    cosd(theta)  0 sind(theta) 0;
    0            1 0           0;
    -sind(theta) 0 cosd(theta) 0;
    0            0 0           1] * [
    eye(3) [0;0;L2]; [0 0 0 1]
    ];
% H1 rotate from origin with theta1
H3 = @(theta) [
    cosd(theta)  0 sind(theta) 0;
    0            1 0           0;
    -sind(theta) 0 cosd(theta) 0;
    0            0 0           1] * [
    eye(3) [0;0;L3]; [0 0 0 1]
    ];

% initial home pose
x = [0 0 0 0];
y = [0 0 0 0];
z = [0 L1 L1+L2 L1+L2+L3];
h_plot = plot3(x, y, z, '-ko', 'LineWidth', 2, 'MarkerSize', 10, ...
    'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor', [0.5,0.5,0.5]);
limitL = L1+L2+L3+1;
grid on;
axis([-limitL limitL -limitL limitL 0 limitL]);
view([240, 30]);
xlabel('x axis'); ylabel('y axis'); zlabel('z axis');

h_x0 = line([0 15], [0 0], [0 0], 'Color', 'r'); 
h_x0_t = text(12,0,0, 'x0');
h_y0 = line([0 0], [0 15], [0 0], 'Color', 'b'); 
h_y0_t = text(0, 12,0, 'y0');

% create start button
%isStop = false;
%btn = uicontrol('Style', 'pushbutton', 'String', 'Stop', ...
%    'Position', [0 0 50 20], 'Callback', 'isStop=true;');
% wait for start button
%while(~isStart) pause(1); end
target_theta = [90 -90 -30];
% normalize angle in degree
% target_theta = mod(target_theta, 360);
while ~all(theta == target_theta)
  diff_theta = abs(target_theta - theta);
  sign_theta = sign(target_theta - theta);
  if diff_theta(1) > 1
    theta(1) = theta(1) + sign_theta(1);
  elseif diff_theta(1) > 0
    theta(1) = theta(1) + sign_theta(1) * diff_theta(1);
  elseif diff_theta(2) > 1
    theta(2) = theta(2) + sign_theta(2);
  elseif diff_theta(2) > 0
    theta(2) = theta(2) + sign_theta(2) * diff_theta(2);
  elseif diff_theta(3) > 1
    theta(3) = theta(3) + sign_theta(3);
  elseif diff_theta(3) > 0
    theta(3) = theta(3) + sign_theta(3) * diff_theta(3);
  end
  h = H1(theta(1));
  p = h(1:3, end); x(2) = p(1); y(2) = p(2); z(2) = p(3);

  h = h*H2(theta(2));
  p = h(1:3, end); x(3) = p(1); y(3) = p(2); z(3) = p(3);

  h = h*H3(theta(3));
  p = h(1:3, end); x(4) = p(1); y(4) = p(2); z(4) = p(3);
  
  % rotation x0 axis
  x0_axis = H0(theta(1))*[eye(3) [1 0 0]'; [0 0 0 1]];
  y0_axis = H0(theta(1))*[eye(3) [0 1 0]'; [0 0 0 1]];
  x0_axis = x0_axis(1:3, end)*30;
  y0_axis = y0_axis(1:3, end)*20;
  
  set(h_x0, 'XData', [0 x0_axis(1)], 'YData', [0 x0_axis(2)], 'ZData', [0 x0_axis(3)]);
  set(h_x0_t, 'Position', [x0_axis(1), x0_axis(2), x0_axis(3)]);
  set(h_y0, 'XData', [0 y0_axis(1)], 'YData', [0 y0_axis(2)], 'ZData', [0 y0_axis(3)]);
  set(h_y0_t, 'Position', [y0_axis(1), y0_axis(2), y0_axis(3)]);
  
  set(h_plot, 'XData', x, 'YData', y, 'ZData', z);
  drawnow;
  pause(0.01);
end