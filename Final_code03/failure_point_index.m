function [index] = failure_point_index(label,PostProbs)
%Function to calculate the index of the unsuccessful point with highest
%probability
%   label is the vector containing labels of the points and PostProbs is
%   the vector containing the probabilities
max = -eps ;
for i=1:size(label)
    if (label(i) == -1 )
        if PostProbs(i,2)>max
            max = PostProbs(i,2);
            index = i;
        end
    end
end
end

