function [ itheta ] = ik_ccd( p_target, itheta_L, isLeftMode)
global HS0_L;  global HS0_R; global HS1; global HE0; global HE1;
global HW0; global HW1; global HW2; global HEND;
%IK_CCD_LEFT
% Inverse Kinamatics: CCD with Triangulation
% Ref: Welman C. (1989). Inverse Kinematics and Geometric Constraints for
% Articulated Figure Manipulation. Simon Fraser University. Canada

s = size(p_target);
if s(1) ~= 1
  p_target = p_target';
end
p_target = p_target(1:3);

%p_target = [lx ly lz];

%% Left mode
if strcmp(isLeftMode, 'left')
P = zeros(8, 3); % store position vector (p) of each joint
H = HS0_L * [rotz(itheta_L(1)) [0;0;0]; 0 0 0 1];
P(1, :) = H(1:3, end)';
H = H * HS1 * [roty(itheta_L(2)) [0;0;0]; 0 0 0 1];
P(2, :) = H(1:3, end)';
H = H * HE0 * [rotz(itheta_L(3)) [0;0;0]; 0 0 0 1];
P(3, :) = H(1:3, end)';
H = H * HE1 * [roty(itheta_L(4)) [0;0;0]; 0 0 0 1];
P(4, :) = H(1:3, end)';
H = H * HW0 * [rotz(itheta_L(5)) [0;0;0]; 0 0 0 1];
P(5, :) = H(1:3, end)';
H = H * HW1 * [roty(itheta_L(6)) [0;0;0]; 0 0 0 1];
P(6, :) = H(1:3, end)';
H = H * HW2 * [rotz(itheta_L(7)) [0;0;0]; 0 0 0 1] * HEND;
P(7, :) = H(1:3, end)';
P(8, :) = H(1:3, end)';

C = ones(8,1) * p_target - P;
joint = 7;
iter_L = 0;
stiff = 1;
alpha = 1;
err_L = norm(P(7,:)-p_target);

% create progress bar
hProgress = waitbar(0, '', 'Name', 'Left Arm IK (CCD Method)', ...
    'CreateCancelBtn', 'setappdata(gcbf, ''isCancel'', 1);');
setappdata(hProgress, 'isCancel', 0);

while err_L > 0.01
  
  if getappdata(hProgress, 'isCancel')
      break;
  end
    
  if  err_L < 10
    stiff = 0.1;
  elseif err_L < 50
    stiff = 0.25;
  elseif err_L < 200
    stiff = 0.5;
  end
  joint = joint - 1;
  if joint < 1
    joint = 6;
  end
  iter_L = iter_L + 1;
  if iter_L > 10000
    break;
  else
    waitbar(iter_L/10000, hProgress, sprintf('error: %.4f', err_L));
  end

  a_vector = P(8, :) - P(joint, :);
  c_vector = C(joint, :);

  a = norm(a_vector);
  c = norm(c_vector);

  axis = [0 0 0];
  if joint == 1
    axis = [0 0 1];
  elseif joint == 2 || joint == 4 || joint == 6
    axis = [0 1 0];
  elseif joint == 3 || joint == 5 || joint == 7
    axis = [1 0 0];
  end

  wp = 1;
  k1 = wp * (c_vector * axis') * (a_vector * axis');
  k2 = wp * (a_vector * c_vector');
  k3 = axis * (wp * cross(a_vector, c_vector)');
  theta = atand(k3 / (k2 - k1));
  theta_1 = theta + 180;
  theta_2 = theta - 180;

  old_theta = itheta_L(joint);
  itheta_L(joint) = itheta_L(joint) + stiff * theta;
  H = HS0_L * [rotz(itheta_L(1)) [0;0;0]; 0 0 0 1] ...
  * HS1 * [roty(itheta_L(2)) [0;0;0]; 0 0 0 1] ...
  * HE0 * [rotz(itheta_L(3)) [0;0;0]; 0 0 0 1] ...
  * HE1 * [roty(itheta_L(4)) [0;0;0]; 0 0 0 1] ...
  * HW0 * [rotz(itheta_L(5)) [0;0;0]; 0 0 0 1] ...
  * HW1 * [roty(itheta_L(6)) [0;0;0]; 0 0 0 1] ...
  * HW2 * [rotz(itheta_L(7)) [0;0;0]; 0 0 0 1] * HEND;
  p_end0 = H(1:3, end)';
  itheta_L(joint) = old_theta;

  if theta_1 > -180 && theta_1 < 180
    old_theta = itheta_L(joint);
    itheta_L(joint) = itheta_L(joint) + stiff * theta_1;
    H = HS0_L * [rotz(itheta_L(1)) [0;0;0]; 0 0 0 1] ...
  * HS1 * [roty(itheta_L(2)) [0;0;0]; 0 0 0 1] ...
  * HE0 * [rotz(itheta_L(3)) [0;0;0]; 0 0 0 1] ...
  * HE1 * [roty(itheta_L(4)) [0;0;0]; 0 0 0 1] ...
  * HW0 * [rotz(itheta_L(5)) [0;0;0]; 0 0 0 1] ...
  * HW1 * [roty(itheta_L(6)) [0;0;0]; 0 0 0 1] ...
  * HW2 * [rotz(itheta_L(7)) [0;0;0]; 0 0 0 1] * HEND;
  p_end = H(1:3, end)';
    if norm(p_target - p_end) < norm(p_target - p_end0)
      p_end0 = p_end;
      theta = theta_1;
    end
  itheta_L(joint) = old_theta;
  end
  if theta_2 > -180 && theta_2 < 180
    old_theta = itheta_L(joint);
    itheta_L(joint) = itheta_L(joint) + stiff * theta_2;
    H = HS0_L * [rotz(itheta_L(1)) [0;0;0]; 0 0 0 1] ...
  * HS1 * [roty(itheta_L(2)) [0;0;0]; 0 0 0 1] ...
  * HE0 * [rotz(itheta_L(3)) [0;0;0]; 0 0 0 1] ...
  * HE1 * [roty(itheta_L(4)) [0;0;0]; 0 0 0 1] ...
  * HW0 * [rotz(itheta_L(5)) [0;0;0]; 0 0 0 1] ...
  * HW1 * [roty(itheta_L(6)) [0;0;0]; 0 0 0 1] ...
  * HW2 * [rotz(itheta_L(7)) [0;0;0]; 0 0 0 1] * HEND;
  p_end = H(1:3, end)';
    if norm(p_target - p_end) < norm(p_target - p_end0)
      p_end0 = p_end;
      theta = theta_2;
    end
    itheta_L(joint) = old_theta;
  end

  % Convergenece Checkpoint
  div_err = norm(p_target - p_end0) - err_L;
  if div_err > 0
    stiff = 0.005;
  end

  % Update each joint with theta
  itheta_L(joint) = itheta_L(joint) + stiff * theta;

  if itheta_L(1) > 51
    itheta_L(1) = 51;
  elseif itheta_L(1) < -141
    itheta_L(1) = -141;
  elseif itheta_L(2) > 30
    itheta_L(2) = 30;
  elseif itheta_L(2) < -100
    itheta_L(2) = -100;
  elseif itheta_L(3) > 173.5
    itheta_L(3) = 173.5;
  elseif itheta_L(3) < -173.5
    itheta_L(3) = -173.5;
  elseif itheta_L(4) > 80
    itheta_L(4) = 80;
  elseif itheta_L(4) < -3
    itheta_L(4) = -3;
  elseif itheta_L(5) > 175.25
    itheta_L(5) = 175.25;
  elseif itheta_L(5) < -175.25
    itheta_L(5) = -175.25;
  elseif itheta_L(6) > 120
    itheta_L(6) = 120;
  elseif itheta_L(6) < -90
    itheta_L(6) = -90;
  elseif itheta_L(7) > 175.25
    itheta_L(7) = 175.25;
  elseif itheta_L(7) < -175.25
    itheta_L(7) = -175.25;
  end

  % update kinametics
  H = HS0_L * [rotz(itheta_L(1)) [0;0;0]; 0 0 0 1];
  P(1, :) = H(1:3, end)';
  H = H * HS1 * [roty(itheta_L(2)) [0;0;0]; 0 0 0 1];
  P(2, :) = H(1:3, end)';
  H = H * HE0 * [rotz(itheta_L(3)) [0;0;0]; 0 0 0 1];
  P(3, :) = H(1:3, end)';
  H = H * HE1 * [roty(itheta_L(4)) [0;0;0]; 0 0 0 1];
  P(4, :) = H(1:3, end)';
  H = H * HW0 * [rotz(itheta_L(5)) [0;0;0]; 0 0 0 1];
  P(5, :) = H(1:3, end)';
  H = H * HW1 * [roty(itheta_L(6)) [0;0;0]; 0 0 0 1];
  P(6, :) = H(1:3, end)';
  H = H * HW2 * [rotz(itheta_L(7)) [0;0;0]; 0 0 0 1] * HEND;
  P(7, :) = H(1:3, end)';
  P(8, :) = H(1:3, end)';

  C = ones(8,1) * p_target - P;
  % update error
  err_L = norm(P(7,:)-p_target);
end

itheta = itheta_L;
elseif strcmp(isLeftMode, 'right')
  
%% Right mode
itheta_R = itheta_L;
P = zeros(8, 3); % store position vector (p) of each joint
H = HS0_R * [rotz(-itheta_R(1)) [0;0;0]; 0 0 0 1];
P(1, :) = H(1:3, end)';
H = H * HS1 * [roty(itheta_R(2)) [0;0;0]; 0 0 0 1];
P(2, :) = H(1:3, end)';
H = H * HE0 * [rotz(itheta_R(3)) [0;0;0]; 0 0 0 1];
P(3, :) = H(1:3, end)';
H = H * HE1 * [roty(itheta_R(4)) [0;0;0]; 0 0 0 1];
P(4, :) = H(1:3, end)';
H = H * HW0 * [rotz(itheta_R(5)) [0;0;0]; 0 0 0 1];
P(5, :) = H(1:3, end)';
H = H * HW1 * [roty(itheta_R(6)) [0;0;0]; 0 0 0 1];
P(6, :) = H(1:3, end)';
H = H * HW2 * [rotz(itheta_R(7)) [0;0;0]; 0 0 0 1] * HEND;
P(7, :) = H(1:3, end)';
P(8, :) = H(1:3, end)';

C = ones(8,1) * p_target - P;
joint = 7;
iter_R = 0;
stiff = 1;
err_R = norm(P(7,:)-p_target);

% create progress bar
hProgress = waitbar(0, '', 'Name', 'Right Arm IK (CCD Method)', ...
    'CreateCancelBtn', 'setappdata(gcbf, ''isCancel'', 1);');
setappdata(hProgress, 'isCancel', 0);

  while err_R > 0.01
    
    if getappdata(hProgress, 'isCancel')
      break;
    end
    
    if  err_R < 10
      stiff = 0.1;
    elseif err_R < 50
      stiff = 0.25;
    elseif err_R < 200
      stiff = 0.5;
    end
    joint = joint - 1;
    if joint < 1
      joint = 6;
    end
    iter_R = iter_R + 1;
    if iter_R > 10000
      break;
    else
      waitbar(iter_R/10000, hProgress, sprintf('error: %.4f', err_R));
    end
      
    a_vector = P(8, :) - P(joint, :);
    c_vector = C(joint, :);
    
    a = norm(a_vector);
    c = norm(c_vector);
   
    axis = [0 0 0];
    if joint == 1
      axis = [0 0 1];
    elseif joint == 2 || joint == 4 || joint == 6
      axis = [0 1 0];
    elseif joint == 3 || joint == 5 || joint == 7
      axis = [1 0 0];
    end
    
    k1 = (c_vector * axis') * (a_vector * axis');
    k2 = a_vector * c_vector';
    k3 = axis * cross(a_vector, c_vector)';
    theta = atand(k3 / (k2 - k1));
    theta_1 = theta + 180;
    theta_2 = theta - 180;
    
    % select the best theta
    old_theta = itheta_R(joint);
    itheta_R(joint) = itheta_R(joint) + stiff * theta;
    H = HS0_R * [rotz(-itheta_R(1)) [0;0;0]; 0 0 0 1] ...
    * HS1 * [roty(itheta_R(2)) [0;0;0]; 0 0 0 1] ...
    * HE0 * [rotz(itheta_R(3)) [0;0;0]; 0 0 0 1] ...
    * HE1 * [roty(itheta_R(4)) [0;0;0]; 0 0 0 1] ...
    * HW0 * [rotz(itheta_R(5)) [0;0;0]; 0 0 0 1] ...
    * HW1 * [roty(itheta_R(6)) [0;0;0]; 0 0 0 1] ...
    * HW2 * [rotz(itheta_R(7)) [0;0;0]; 0 0 0 1] * HEND;
    p_end0 = H(1:3, end)';
    itheta_R(joint) = old_theta;
    
    if theta_1 > -180 && theta_1 < 180
      old_theta = itheta_R(joint);
      itheta_R(joint) = itheta_R(joint) + stiff * theta_1;
      H = HS0_R * [rotz(-itheta_R(1)) [0;0;0]; 0 0 0 1] ...
    * HS1 * [roty(itheta_R(2)) [0;0;0]; 0 0 0 1] ...
    * HE0 * [rotz(itheta_R(3)) [0;0;0]; 0 0 0 1] ...
    * HE1 * [roty(itheta_R(4)) [0;0;0]; 0 0 0 1] ...
    * HW0 * [rotz(itheta_R(5)) [0;0;0]; 0 0 0 1] ...
    * HW1 * [roty(itheta_R(6)) [0;0;0]; 0 0 0 1] ...
    * HW2 * [rotz(itheta_R(7)) [0;0;0]; 0 0 0 1] * HEND;
    p_end = H(1:3, end)';
      if norm(p_target - p_end) < norm(p_target - p_end0)
        p_end0 = p_end;
        theta = theta_1;
      end
    itheta_R(joint) = old_theta;
    end
    if theta_2 > -180 && theta_2 < 180
      old_theta = itheta_R(joint);
      itheta_R(joint) = itheta_R(joint) + stiff * theta_2;
      H = HS0_R * [rotz(-itheta_R(1)) [0;0;0]; 0 0 0 1] ...
    * HS1 * [roty(itheta_R(2)) [0;0;0]; 0 0 0 1] ...
    * HE0 * [rotz(itheta_R(3)) [0;0;0]; 0 0 0 1] ...
    * HE1 * [roty(itheta_R(4)) [0;0;0]; 0 0 0 1] ...
    * HW0 * [rotz(itheta_R(5)) [0;0;0]; 0 0 0 1] ...
    * HW1 * [roty(itheta_R(6)) [0;0;0]; 0 0 0 1] ...
    * HW2 * [rotz(itheta_R(7)) [0;0;0]; 0 0 0 1] * HEND;
    p_end = H(1:3, end)';
      if norm(p_target - p_end) < norm(p_target - p_end0)
        theta = theta_2;
        p_end0 = p_end;
      end
      itheta_R(joint) = old_theta;
    end
    
    % Convergenece Checkpoint
    div_err = norm(p_target - p_end0) - err_R;
    if div_err > 0
      stiff = 0.005;
    end
    
    % update each joint with theta
    itheta_R(joint) = itheta_R(joint) + stiff * theta;
    
    if itheta_R(1) > 51
      itheta_R(1) = 51;
    elseif itheta_R(1) < -141
      itheta_R(1) = -141;
    elseif itheta_R(2) > 30
      itheta_R(2) = 30;
    elseif itheta_R(2) < -100
      itheta_R(2) = -100;
    elseif itheta_R(3) > 173.5
      itheta_R(3) = 173.5;
    elseif itheta_R(3) < -173.5
      itheta_R(3) = -173.5;
    elseif itheta_R(4) > 80
      itheta_R(4) = 80;
    elseif itheta_R(4) < -3
      itheta_R(4) = -3;
    elseif itheta_R(5) > 175.25
      itheta_R(5) = 175.25;
    elseif itheta_R(5) < -175.25
      itheta_R(5) = -175.25;
    elseif itheta_R(6) > 120
      itheta_R(6) = 120;
    elseif itheta_R(6) < -90
      itheta_R(6) = -90;
    elseif itheta_R(7) > 175.25
      itheta_R(7) = 175.25;
    elseif itheta_R(7) < -175.25
      itheta_R(7) = -175.25;
    end
    
    % update kinametics
    H = HS0_R * [rotz(-itheta_R(1)) [0;0;0]; 0 0 0 1];
    P(1, :) = H(1:3, end)';
    H = H * HS1 * [roty(itheta_R(2)) [0;0;0]; 0 0 0 1];
    P(2, :) = H(1:3, end)';
    H = H * HE0 * [rotz(itheta_R(3)) [0;0;0]; 0 0 0 1];
    P(3, :) = H(1:3, end)';
    H = H * HE1 * [roty(itheta_R(4)) [0;0;0]; 0 0 0 1];
    P(4, :) = H(1:3, end)';
    H = H * HW0 * [rotz(itheta_R(5)) [0;0;0]; 0 0 0 1];
    P(5, :) = H(1:3, end)';
    H = H * HW1 * [roty(itheta_R(6)) [0;0;0]; 0 0 0 1];
    P(6, :) = H(1:3, end)';
    H = H * HW2 * [rotz(itheta_R(7)) [0;0;0]; 0 0 0 1] * HEND;
    P(7, :) = H(1:3, end)';
    P(8, :) = H(1:3, end)';

    C = ones(8,1) * p_target - P;
    % update error
    err_R = norm(P(7,:)-p_target);
  end
  itheta = itheta_R;
end
delete(hProgress);
end

