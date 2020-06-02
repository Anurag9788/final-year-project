function Sdash=GetNextSubspaceFeatureVector(T)
global T123;
  % [I,map] = rgb2ind(T123,65535);
  T=uint8(T);
    [cA1,cH1,cV1,cD1]=dwt2(T,'db1');
%     sz=size(cA1);
%    cA1_vector=reshape(cA1,1,sz(1)*sz(2));
%    cH1_vector=reshape(cH1,1,sz(1)*sz(2));
%    cV1_vector=reshape(cV1,1,sz(1)*sz(2));
%    cD1_vector=reshape(cD1,1,sz(1)*sz(2));
%    X=horzcat(cA1_vector,cH1_vector,cV1_vector,cD1_vector);
   [coefs_cA1,scores_cA1,variances_cA1,t2_cA1] = princomp(cA1);
   [coefs_cH1,scores_cH1,variances_cH1,t2_cH1] = princomp(cH1);
   [coefs_cV1,scores_cV1,variances_cV1,t2_cV1] = princomp(cV1);
   [coefs_cD1,scores_cD1,variances_cD1,t2_cD1] = princomp(cD1);
%    sz=size(coefs_cA1);
%    eig_cA1 = sort(real(eig(coefs_cA1)),'descend'); 
%    eig_cH1 = sort(real(eig(coefs_cH1)),'descend'); 
%    eig_cV1 = sort(real(eig(coefs_cV1)),'descend'); 
%    eig_cD1 = sort(real(eig(coefs_cD1)),'descend'); 
%   S=horzcat(eig_cA1(1:10),eig_cH1(1:10),eig_cV1(1:10),eig_cD1(1:10));
   eig_cA1 = real(eig(coefs_cA1)); 
   eig_cH1 = real(eig(coefs_cH1)); 
   eig_cV1 = real(eig(coefs_cV1)); 
   eig_cD1 = real(eig(coefs_cD1)); 
   Sdash=horzcat(eig_cA1(1:10),eig_cH1(1:10),eig_cV1(1:10),eig_cD1(1:10));


end