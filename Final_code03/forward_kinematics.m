function [g_st,w_e,p] = forward_kinematics(theta)

% Spatial Jacobian
q1 = [0.0650; 0.2582; 0.1190];%S_0 %ok
q2 = [0.1138; 0.3070; 0.3894]; %S_1  %ok
q3 = [0.1138; 0.3070; 0.3894];%E_0
q4 = [0.3714; 0.5646; 0.32];%E_1
q5 = [0.3714; 0.5646; 0.32];%W_0
q6 = [0.6361; 0.8293; 0.31];%W_1
q7 = [0.6361; 0.8293; 0.31];%W_2
% q1 = [0.065008; 0.25824; 0.118990];%S_0
% q2 = [0.1138; 0.30724; 0.3893]; %S_1
% q3 = [0.18643; 0.37885; 0.38944];%E_0
% q4 = [0.37338; 0.56313; 0.32078];%E_1
% q5 = [0.44715; 0.63586; 0.32057];%W_0
% q6 = [0.63991; 0.82589; 0.31002];%W_1
% q7 = [0.72249; 0.90731; 0.30961];%W_2


Orientation = [  -0.0011 -0.0002 0.3794 0.9252;
                 -0.6548 -0.2690 0.2675 0.6536;
                 -0.2683  0.6537 0.2682 0.6547;
                 -0.6547 -0.2677 0.2688 0.6537;
                 -0.2694  0.6545 0.2671 0.6539;
                 -0.6556 -0.2674 0.2691 0.6528;
                 -0.2690  0.6552 0.2674 0.6531;
                 -0.2704 0.6548 0.2691 0.6524];

R = QuaternionToMatrix(Orientation);

for i=1:8
    w(:,i) = R(:,3,i);
%     s = w1(:,i).^2;
%     s1 = sqrt(sum(s));
%     w(:,i) = w1(:,i)/s1;
end
w_e = w(:,8);
% joint_limits = [
%     -2.3    0.7; % s0
%     -2.0    0.9; % s1
%     -2.9    2.9; % e0
%     0       2.5; % e1
%     -2.9    2.9; % w0
%     -1.4    1.9; % w1
%     -2.9    2.9; % w2
% ];

q = [q1 q2 q3 q4 q5 q6 q7];

%%
% Jacobian
% w = [ 0  -0.7020    0.7120   -0.7020    0.7120   -0.7020    0.7120  
%     0    0.7120    0.7020    0.7120    0.7020    0.7120    0.7020    
%     1   0    0   0   0   0   0   ];
% p_ab = q(1:3,7); %check this
%p_ab = [0.8002;0.99045;0.30956];
p_ab = [0.7984;0.9916;0.31];
g0 = [R(:,:,8) p_ab; 0 0 0 1];
g_ab= eye(4,4);
for i=1:7

    [e(:,:,i),xi(:,:,i),xih(:,:,i)] = expon(w(:,i), q(:,i), theta(i));
    g_ab = g_ab*e(:,:,i); % Forward Kinematics
end
g_st = g_ab*g0;
p = g_st(1:3,4);
end