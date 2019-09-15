% Jonathon Greene
% Profesor Chakraborty
% MEC 696(2)
% Slice Script

clear
clc

%% Generate simulated data

% discretize xy

for a = 1:21
    for b =1:21
        x(b,1:21) = [linspace(0,10,21)];
        y(1:21,b) = linspace(0,10,21);
    end
X(1:21,1:21,a) = x;
Y(1:21,1:21,a) = y;
Z(1:21,1:21,a) = a*ones(21,21);
end

% define the cross sections to view
xslice = [];                               
yslice = [];
zslice = ([3 4 5 6 7 8 9 10]);

load fluidtemp temp  

slice(X, Y, Z, temp, xslice, yslice, zslice)    % display the slices

% set transparency to correlate to the data values.
alpha('color');
colormap(jet);