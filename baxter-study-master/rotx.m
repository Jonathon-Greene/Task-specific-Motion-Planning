function [ h ] = rotx( a )
%ROTX Summary of this function goes here
%   Detailed explanation goes here

h = [1 0 0; 0 cosd(a) -sind(a); 0 sind(a) cosd(a)];
end

