function [ q ] = GetDensity1( handles,T,H,W )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%q = zeros(Lmap,1);
%colour = linspace(1,Lmap,Lmap);
TGray=rgb2gray(T);
T=double(TGray);
sigma=var(var(T));
%sigmasq=sigma^2;
%[r c n]=size(T);
for x=1:W
    for y=1:H 
        %q(T(y,x)+1) = q(T(y,x)+1)+k(y,x);
        t=(1-((x/sigma)^2+(y/sigma)^2));
       nVal=0.75*t;
       if  nVal< 0
           nVal=0;
       end
        Q(x,y)=nVal;
        
    end
end

% Normalizing
C =0.5;% 1/sum(sum(k));
q = C.*Q;

% Plotting the estimated densities

    %figure(2)
    %plot(q);
    figure (4)
%     scrsz = get(0,'ScreenSize');
%     set(4,'Position',[scrsz(3)/4 scrsz(4)/4 ...
%         scrsz(3)/1.5 scrsz(4)/1.5])
%     subplot(2,2,1)
    mesh(q);
    surf(q);
    shading interp

end

