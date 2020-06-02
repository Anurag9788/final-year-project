function [y0,x0,H,W, SelectedObj ] = GetSelectedObjectManual( handles,frame1,fno,x,y,w,h )

global x0 y0 W H frameno;
if fno==frameno
    x0=x;
    y0=y;
    W=w;
    H=h;
    save W W ;
    save H H ;
end


frame1=uint8(frame1);
SelectedObj = frame1(y0:y0+H-1,x0:x0+W-1,:);
imshow(SelectedObj,'parent',handles.axes1);
%
%[ctr x]=imhist(SelectedObj(:,:,1));
%[ctg x]=imhist(SelectedObj(:,:,2));
%[ctb x]=imhist(SelectedObj(:,:,3));
%histo(1,:)=ctr';
%histo(2,:)=ctg';
%histo(3,:)=ctb';
%h1=horzcat(ctr',ctg',ctb');
%hcolor={'Red','Green','Blue'};

%h1=figure(3);

 %hold on 
%plot(handles.axes2,histo(1,:),'r');
%plot(handles.axes3,histo(2,:),'g');
%plot(handles.axes4,histo(3,:),'b');
%SelectedObjGray=rgb2gray(SelectedObj);
%[ct x]=imhist(SelectedObjGray);
%bar(handles.axes5,ct');
%hold off

end

