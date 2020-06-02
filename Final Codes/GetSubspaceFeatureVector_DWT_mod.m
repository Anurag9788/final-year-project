function GetSubspaceFeatureVector_DWT_mod(T_Org_Gray,wavelet_type)
   global S T1;
    T1=T_Org_Gray;
    [cA12,cH12,cV12,cD12]=dwt2(T_Org_Gray,'db2');
   
   cA1=cA12;
    sz=size(cA1);
    r1=sz(1)/3;
    r2=sz(1)*2/3;
    c1=sz(2)/3;
    c2=sz(2)*2/3;
    S=cA1(r1:r2,c1:c2);
    Smax=max(max(S));
    S=S/Smax; 
end