function [T_discrete] = discrete_ws(n_Rz, delta_z, layers, res, z_min)
%discrete_ws creates a discretized version of the workspace to be tested.
%It takes in the demonstrated motion and desired discretization parameters,
%and outputs a 3D matrix of 4x4xn rotation matrices, where n is the size of
%the discretized workspace.
% This function assumes a default workspace size of 1m(y) x 2m(x), with the
% center located 1m from default y CYS, 0 from default x CYS, and 0 from
% default z CYS 

% INPUTS
%   n_Rz: integer, desired number of discrete orientations about the z axis
%   delta_z: double, desired change in z height (+) from the workspace
%       plane. units are meters. 
%   layers: integer, desired number of discrete delta_z layers.
%   res: integer, desired resolution of the discretized xy workspace in
%       total number of xy points across the workspace. Note: total number
%       of discrete point across the workspace will be 
%       res*layers*n_Rz
%   z_min: starting point for plane
% OUTPUTS
%   T_discrete: 3D matrix, transformation matrices of each discrete point
%       generated on the workspace. Transformation from the world CYS to
%       the desired end effector position

n_x = sqrt(res*2); 
n_y = sqrt(res/2);

x_min = -1; 
x_max = 1; 
X = linspace(x_min, x_max, n_x);

y_min = 0; %(1-.5);
y_max = 1; %(1+.5);
Y = linspace(y_min, y_max, n_y);

if delta_z == 0
    z_max = z_min;
    delta_z = 1;
else
    z_max = layers*delta_z;
end

if n_Rz > 1
Rz_min = -pi/6; %radians
Rz_max = pi/6; %radians
RZ = linspace(Rz_min, Rz_max, n_Rz);
else
    RZ = 0;
end
    


count = 1;
count_final  = size(Y,2) * size(X,2) * layers * n_Rz;
T_discrete = zeros(4,4,count_final);

load('C:\Users\QKX486\Documents\MATLAB\SBU\MEC696_II\optimalcelldemo2.mat','theta1');
theta1 = degtorad(theta1);
[~, g_st1, ~] = denoising(theta1');
T_demo = g_st1(:,:,end); % Final ee configuration for demo
R_demo = T_demo(1:3,1:3);%Rotation matrix of the Final Configuration
%for x = x_min:delta_x:x_max

for x = X
    for y = Y
        for z = z_min:delta_z:z_max
            for Rz = RZ
                P = [x y z]';

                delRz = [cos(Rz) -sin(Rz) 0; ...
                    sin(Rz) cos(Rz) 0; ...
                    0 0 1]; % deviation of current orientation from demo
                    % orientation (z axis)

                delRy = [cos(Rz) 0 sin(Rz); ...
                    0 1 0; ...
                    -sin(Rz) 0 cos(Rz)]; % deviation of current ...
                    % orientation from demo orientation (y axis)

                 delR = delRz*delRy;

                T_discrete(:,:,count) = [R_demo * delR P ; zeros(1,3) 1] ;
                count = count+1;
            end
        end    
    end
end

end

