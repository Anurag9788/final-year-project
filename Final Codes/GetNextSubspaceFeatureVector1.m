function Sdash=GetNextSubspaceFeatureVector1(T) 

T=uint8(T);
[cA1,cH1,cV1,cD1]=dwt2(T,'db1');
[a,b,~] =size(cA1);
r1=a/3;
r2=a*2/3;
c1=b/3;
c2=b*2/3;
Sdash=[cA1(r1:r2,c1:c2)]; %, cH1(r1:r2,c1:c2), cV1(r1:r2,c1:c2), cD1(r1:r2,c1:c2)];
Sdashmax=max(max(Sdash));
Sdash=Sdash/Sdashmax;

end