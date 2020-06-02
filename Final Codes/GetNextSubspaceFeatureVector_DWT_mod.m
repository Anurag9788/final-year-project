function Sdash=GetNextSubspaceFeatureVector_DWT_mod(T,wavelet_type)

%    [cA1,cH1,cV1,cD1]=dwt2(T_Org_Gray,'haar');
    T=uint8(T);
    T_Org_Gray = T;
   [cA12,cH12,cV12,cD12]=dwt2(T_Org_Gray,'db2');
   Sdash=cA12;
    sz=size(Sdash);
    r1=sz(1)/3;
    r2=sz(1)*2/3;
    c1=sz(2)/3;
    c2=sz(2)*2/3;
    Sdash=Sdash(r1:r2,c1:c2);
    Smax=max(max(Sdash));
    Sdash=Sdash/Smax; 
end