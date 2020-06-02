function   error=GetMSE( S,Sdash)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% S=S./max(S);
% Sdash=Sdash./max(Sdash);

err=(Sdash-S).^2;


error=mse(Sdash,S);
%psnr=10*log10(1/error);


%plot(hf,err);
% str=strcat('MSE=',num2str(error),',  SNR=',num2str(psnr));
% title(str);


end

