function [ x1,y1,bplot ] =GetNewPositionBy_DWT(handles,frame,x,y,H,W,T_Org)
global loss X S T T1 wt T123;

framegray=rgb2gray(frame);
[height width d3]=size(frame);
SelectedObj=[];
th=30;
n_itr=1;
%z=min(round(W/2),round(H/2));
z=16;


T=[];
Sdash=[];
delta_s=[];
left=round(x-z);
up=round(y-z);
right=round(x+z);
down=round(y+z);


m=1;
n=1;
stp=3;
dyi=1;
thr=200;
%.......................................................................
if up<1
    up=1;
end
if left <1
   left=1;
end
if down >height 
    down = height;
end
if right > width
    right =width;
end
%........................................................................
for i=up:stp:down-stp
    n=1;
    dxj=1;
    for j=left:stp:right-stp
    if i < 1 || j < 1|| i > height || j > width 
          continue;
    end
      T123=frame(i:i+H-1,j:j+W-1,:);
        T=framegray(i:i+H-1,j:j+W-1);
        T=imnoise(T,'gaussian');
        for counter=1:5
        Sdash=GetNextSubspaceFeatureVector_DWT(T);
        end
        D=SSD(S,Sdash);
        if m==1
            min_D=D;
            dy=dyi;
            dx=dxj;
        else
            if D<min_D
            min_D=D;
            dy=dyi;
            dx=dxj;
            end
            
        end
        

        delta_s(m,n)=D;
        n=n+1;
        dxj=dxj+1;
    end
    m=m+1;
    dyi=dyi+1;
end


thr1=(min_D);
%if thr1<thr
 x1=left+((dx-1)*stp);
 y1=up+((dy-1)*stp);
%  else
%  x1=x;
%  y1=y;
% end
 SelectedObj = frame(y1:y1+H-1,x1:x1+W-1,:);
 T=SelectedObj;
 bplot=1;

   
end
