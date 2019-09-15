function [ h ] = rotz( angle_d )
%ROTZ Summary of this function goes here
%   Detailed explanation goes here

h = [cosd(angle_d) -sind(angle_d) 0; sind(angle_d) cosd(angle_d) 0; 0 0 1];
end

