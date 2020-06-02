function [f,w] = GetSimilarity(q,p,T1,k,H,W)
global T_Org;
w = zeros(H,W);
f = 0;
L1=length(q);
L2=length(p);
if L1<L2
    l=abs(L1-L2);
    for i=1:l
        q(L1+i)=0;
    end
end
if L2<L1
    l=abs(L1-L2);
    for i=1:l
        p(L2+i)=0;
    end
end

for i=1:H
    for j=1:W
        nVal=T1(i,j);
        if p(nVal+1)~=0
        w(i,j) = sqrt(q(nVal+1)/p(nVal+1));
        end
        f = f+w(i,j)*k(i,j);
    end
end
% Normalization of f
f = f/(H*W);