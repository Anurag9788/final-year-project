function GetSubspaceFeatureVector_DWT(T_Org_Gray)
   global S T1;
    T1=T_Org_Gray;
     
   [cA1,cH1,cV1,cD1]=dwt2(T_Org_Gray,'db1');
   sz=size(cA1);
    r1=sz(1)/3;
r2=sz(1)*2/3;
c1=sz(2)/3;
c2=sz(2)*2/3;
    S=cA1(r1:r2,c1:c2);
    Smax=max(max(S));
    S=S/Smax;
  
 
   
end