clear; clc; close;

% setting Length of bar
%         L1     L2        L3
%    o--------o--------o--------3
% origin (home)             end-effector (ee)
%
%
%  
%       theta1 H1   theta2 H2    theta3 H3
%    o-----------o-------------o-----------3

L1 = 30;
L2 = 20;
L3 = 10;
theta = [0 0 0];

% H1 rotate from origin with theta1
H1 = @(theta) [
    cosd(theta) -sind(theta) 0 0;
    sind(theta) cosd(theta)  0 0;
    0          0             1 0;
    0          0             0 1] * [
    eye(3) [L1;0;0]; [0 0 0 1]
    ];
% H1 rotate from origin with theta1
H2 = @(theta) [
    cosd(theta) -sind(theta) 0 0;
    sind(theta) cosd(theta)  0 0;
    0          0             1 0;
    0          0             0 1] * [
    eye(3) [L2;0;0]; [0 0 0 1]
    ];
% H1 rotate from origin with theta1
H3 = @(theta) [
    cosd(theta) -sind(theta) 0 0;
    sind(theta) cosd(theta)  0 0;
    0          0             1 0;
    0          0             0 1] * [
    eye(3) [L3;0;0]; [0 0 0 1]
    ];

% initial home pose
x = [0 L1 L1+L2 L1+L2+L3];
y = [0 0 0 0];
h_plot = plot(x, y, '-ko', 'LineWidth', 2, 'MarkerSize', 10, ...
    'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor', [0.5,0.5,0.5]);
limitL = L1+L2+L3+10;
axis([-limitL limitL -limitL limitL]);

% create start button
isStop = false;
btn = uicontrol('Style', 'pushbutton', 'String', 'Stop', ...
    'Position', [0 0 50 20], 'Callback', 'isStop=true;');
% wait for start button
%while(~isStart) pause(1); end
target_theta = [-10 -100 60];
% normalize angle in degree
% target_theta = mod(target_theta, 360);
while ~all(theta == target_theta)
  diff_theta = abs(target_theta - theta)
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
  p = h(1:3, end); x(2) = p(1); y(2) = p(2);

  h = h*H2(theta(2));
  p = h(1:3, end); x(3) = p(1); y(3) = p(2);

  h = h*H3(theta(3));
  p = h(1:3, end); x(4) = p(1); y(4) = p(2);

  set(h_plot, 'XData', x, 'YData', y);
  drawnow;
  pause(0.1);
end