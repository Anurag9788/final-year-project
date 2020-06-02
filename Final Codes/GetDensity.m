function [ p ] = GetDensity( handles,T,Lmap,k,H,W )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

p = zeros(Lmap,1);
colour = linspace(1,Lmap,Lmap);
for x=1:W
    for y=1:H 
        p(T(y,x)+1) = p(T(y,x)+1)+k(y,x);
    end
end

% Normalizing
C = 1/sum(sum(k));
p = C.*p;

% Plotting the estimated densities

   % figure(10)
   % plot(handles.axes12,colour,p);


end

