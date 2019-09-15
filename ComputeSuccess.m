
function [HM] = ComputeSuccess(Temp_ELM)
% All unique xy points in the learned data
HM = unique(Temp_ELM(:,[6:7]),'rows');

% Columns 3 and 4 are sum of successes and total rotations, respectfully.
% Column 5 is the percent success (col3/col4)
HM(:,[3:5]) = zeros(size(HM,1),3);

% Count number of successes at each xy point (sum rotations)
for i = 1:size(HM,1)
    for j = 1:size(Temp_ELM,1)
        if HM(i,[1:2]) == Temp_ELM(j,[6:7])
            HM(i,3) = HM(i,3) + Temp_ELM(j,1);
            HM(i,4) = HM(i,4) + 1;
        end
    end    
end

% Calculate column 5 for overall percent success/failure
for k = 1:size(HM,1)
HM(k,5) = HM(k,3)/HM(k,4);
end

% CONSIDER CHANGING COLUMN 4 TO A CONSTANT (TOTAL NUMBER OF ROTATIONS
% DISCRETIZED), INSTEAD OF VARIABLE. THIS IS MORE CONSERVATIVE.
end