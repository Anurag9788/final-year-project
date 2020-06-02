function MSAlgo( handles,FilePath )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global frameno q Videoobj position T Tracking_org ;
time_elapsed = [] ;
%    frameno=frameno+1;
%    mov(frameno).cdata = read(vidObj, frameno);
%    % mov(k).cdata=uint8(mov(k).cdata);
%    frame=uint8(mov(frameno).cdata);
%    imshow(frame,hf);
WriterObj = VideoWriter('TrackedVideo.avi');
open(WriterObj);

global Tracking T_Org;
Videoobj=VideoReader(FilePath);
nFrames=Videoobj.numberOfFrames;
vidHeight=Videoobj.Height;
vidWidth=Videoobj.Width;
FrameRate=Videoobj.FrameRate;
frame=read(Videoobj,frameno);
hf = figure(100);
%hf = handles.axes11;
set(hf, 'position', [0 0 vidWidth vidHeight])
% Read one frame at a time.
 loss=0;
 R=0.9;
 tstart=tic;
for frno = frameno : nFrames
    if Tracking==1
    frame=read(Videoobj,frno);
  % frame=uint8(mov(frno).cdata);
   imshow(frame);
    [rows cols n1]=size(frame);
   pause(0.1);
    if frno==frameno
    [y0,x0,H,W, SelectedObj ]=GetSelectedObject( handles,frame,frno );
    T_Org=SelectedObj;
  % end
  % T=SelectedObj;
   rectangle('Position',[x0,y0,W,H],'EdgeColor','y');
   WriterObj.writeVideo(getframe(figure(100))) ;
            
   [ k,gx,gy ]=ParzenWindow( handles,W,H,R );
   [I,map] = rgb2ind(frame,65535);
    Lmap = length(map)+1;
    T_Org = rgb2ind(T_Org,map);
    colour = linspace(1,Lmap,Lmap);
    % Estimation of the target PDF
    q = GetDensity(handles,T_Org,Lmap,k,H,W);
    plot(handles.axes9,colour,q);
    x=x0;
    y=y0;
    position = [x0,y0];
            corner_list = [x0, y0] ;
            time0 = tic;
    Tfrno=frno-frameno+1;
       trackInfo(Tfrno,1)=frno;
       trackInfo(Tfrno,2)=x0+0.5*W;
       trackInfo(Tfrno,3)=y0+H;
       bplot = 1 ;
                corner_list = [corner_list; x, y] ;
    else
    
    
   
   % f = cat(2,f,fi);
   [ x,y,bplot ] = GetNewPositionByMeanShift(handles,R,frame,x,y,H,W,q,T_Org);
   position = [x,y];
                corner_list = [corner_list; x, y] ;
                time_elapsed = [time_elapsed, toc(time0)];
   if bplot==1
       Tfrno=frno-frameno+1;
       trackInfo(Tfrno,1)=frno;
       trackInfo(Tfrno,2)=x+0.5*W;
       trackInfo(Tfrno,3)=y+H;
       figure(100);
      
   rectangle('Position',[x,y,W,H],'EdgeColor','y');
   drawnow ;
                    WriterObj.writeVideo(getframe(figure(100)));
   set(handles.text11,'string','Tracking...');
   set(handles.uitable1,'data',trackInfo);
   else
   set(handles.text11,'string','Object out of tracking Limits');
       break;
      
   end
   %q=p;
    end
    %q = GetDensity(handles,T,H,W);
    else
%        close(vidObj);
        delete(Videoobj);
        break;
    end
end
dlmwrite('tracked_cornersMS.txt', corner_list) ;
temp = ['Mean Computation Time per frame : ', num2str(mean(time_elapsed))] ;
disp(temp);
tElapsed=toc(tstart);
figure(10);
X_cords=trackInfo(:,2);
Y_cords=rows-trackInfo(:,3);
plot(X_cords,Y_cords);
axis([0 cols 0 rows]);
text(X_cords(1)+10,Y_cords(1)+10,'A');
text(X_cords(numel(X_cords))+10,Y_cords(numel(Y_cords))+10,'B');
title('Tracked Object Path');
%movie(hf, mov, 1, FrameRate);
end

