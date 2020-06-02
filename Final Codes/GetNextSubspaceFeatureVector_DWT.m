function Sdash=GetNextSubspaceFeatureVector_DWT(T)

  % [I,map] = rgb2ind(T123,65535);
  T=uint8(T);
   cA1=dwt2(T,'db1');
    a=size(cA1,1);
    b=size(cA1,2);
    c=size(cA1,3);
   r1=a/3;
r2=a*2/3;
c1=b/3;
c2=b*2/3;
    Sdash=cA1(r1:r2,c1:c2);
     Sdashmax=max(max(Sdash));
   Sdash=Sdash/Sdashmax;

end