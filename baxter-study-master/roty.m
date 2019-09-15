function [ h ] = roty( a )
%ROTY Summary of this function goes here
%   Detailed explanation goes here

h = [ cosd(a) 0 sind(a); 0 1 0; -sind(a) 0 cosd(a)];
end

