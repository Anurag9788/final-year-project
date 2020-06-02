function [ k,gx,gy ] = ParzenWindow( handles,W,H,R )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



    sigmaH = (R*H/2)/3;
    sigmaW = (R*W/2)/3;
    % sigma = x/3 as a gaussian is almost equal to 0
    % from 3*sigma.
    for i=1:H
        for j=1:W
            k(i,j) = exp(-.5*((i-.5*H)^2/sigmaH^2+...
                (j-.5*W)^2/sigmaW^2));
        end
    end

[gx,gy] = gradient(-k);
 
h1=handles.axes10;
    mesh(h1,k);
    surf(h1,k);
    %shading interp
    shading(handles.axes10,'interp');


end

