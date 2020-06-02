function imgdwt=Getdwt(handles,frame,dwtlevel)
[row nbcol n]=size(frame);
%perform single-level decomposition of image using db1
switch (dwtlevel)
    case 1
[cA1,cH1,cV1,cD1]=dwt2(frame,'db1');
% Images coding. 
cod_X1 = wcodemat(frame,nbcol); 
cod_cA1 = wcodemat(cA1,nbcol); 
cod_cH1 = wcodemat(cH1,nbcol); 
cod_cV1 = wcodemat(cV1,nbcol); 
cod_cD1 = wcodemat(cD1,nbcol); 
dec2d1  = [cod_cA1,cod_cH1;cod_cV1,cod_cD1];
imshow(uint8(dec2d1),'parent',handles.axes1);
imgdwt=cod_cA1;
    case 2
[cA1,cH1,cV1,cD1]=dwt2(frame,'db1');
% Images coding. 
cod_X1 = wcodemat(frame,nbcol); 
cod_cA1 = wcodemat(cA1,nbcol); 
cod_cH1 = wcodemat(cH1,nbcol); 
cod_cV1 = wcodemat(cV1,nbcol); 
cod_cD1 = wcodemat(cD1,nbcol); 
dec2d1  = [cod_cA1,cod_cH1;cod_cV1,cod_cD1];

imshow(uint8(dec2d1),'parent',handles.axes1);
%.................................2
[cA2,cH2,cV2,cD2]=dwt2(cod_cA1,'db1');
cod_X2 = wcodemat(frame,nbcol); 
cod_cA2 = wcodemat(cA2,nbcol); 
cod_cH2 = wcodemat(cH2,nbcol); 
cod_cV2 = wcodemat(cV2,nbcol); 
cod_cD2 = wcodemat(cD2,nbcol); 
dec2d2  = [cod_cA2,cod_cH2;cod_cV2,cod_cD2];

dec2d_2=[dec2d2,cod_cH1;cod_cV1,cod_cD1];
imshow(uint8(dec2d_2),'parent',handles.axes2);
imgdwt=cod_cA1;
    case 3
%..........................3
[cA1,cH1,cV1,cD1]=dwt2(frame,'db1');
% Images coding. 
cod_X1 = wcodemat(frame,nbcol); 
cod_cA1 = wcodemat(cA1,nbcol); 
cod_cH1 = wcodemat(cH1,nbcol); 
cod_cV1 = wcodemat(cV1,nbcol); 
cod_cD1 = wcodemat(cD1,nbcol); 
dec2d1  = [cod_cA1,cod_cH1;cod_cV1,cod_cD1];

imshow(uint8(dec2d1),'parent',handles.axes1);
%.................................2
[cA2,cH2,cV2,cD2]=dwt2(cod_cA1,'db1');
cod_X2 = wcodemat(frame,nbcol); 
cod_cA2 = wcodemat(cA2,nbcol); 
cod_cH2 = wcodemat(cH2,nbcol); 
cod_cV2 = wcodemat(cV2,nbcol); 
cod_cD2 = wcodemat(cD2,nbcol); 
dec2d2  = [cod_cA2,cod_cH2;cod_cV2,cod_cD2];

dec2d_2=[dec2d2,cod_cH1;cod_cV1,cod_cD1];
imshow(uint8(dec2d_2),'parent',handles.axes2);

[cA3,cH3,cV3,cD3]=dwt2(cod_cA2,'db1');
cod_X2 = wcodemat(frame,nbcol); 
cod_cA3 = wcodemat(cA3,nbcol); 
cod_cH3 = wcodemat(cH3,nbcol); 
cod_cV3 = wcodemat(cV3,nbcol); 
cod_cD3 = wcodemat(cD3,nbcol); 
dec2d3  = [cod_cA3,cod_cH3;cod_cV3,cod_cD3];

dec2d_3=[dec2d3,cod_cH2;cod_cV2,cod_cD2];
%.........................

dec2d=[dec2d_3,cod_cH1;cod_cV1,cod_cD1];


imshow(uint8(dec2d),'parent',handles.axes3);
imgdwt=cod_cA1;
end




end