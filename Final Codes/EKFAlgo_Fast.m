function EKFAlgo_Fast(handles,FilePath,wavelet_type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global frameno q Videoobj T map position;
time_elapsed = [] ;
%    frameno=frameno+1;
%    mov(frameno).cdata = read(vidObj, frameno);
%    % mov(k).cdata=uint8(mov(k).cdata);
%    frame=uint8(mov(frameno).cdata);
%    imshow(frame,hf);

global Tracking T_Org;

WriterObj = VideoWriter('TrackedVideo.avi');
open(WriterObj);

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
 tic;
 frame_count = 1;
for frno = frameno : nFrames
    if Tracking==1
        frame_count = frame_count + 1;
    frame=read(Videoobj,frno);
  % frame=uint8(mov(frno).cdata);
   imshow(frame);
    [rows cols n1]=size(frame);
   %pause(0.1);
   drawnow;
    if frno==frameno
        [y0,x0,H,W, SelectedObj ]=GetSelectedObject( handles,frame,frno );
    T_Org=SelectedObj;
    T_Org_Gray=rgb2gray(T_Org);
    [I,map] = rgb2ind(T_Org,65535);
    I=T_Org_Gray;
    level = graythresh(I);
    BW = im2bw(I,level);
    %imshow(BW,'parent',handles.axes1);
    
  % end
  % T=SelectedObj;
%   rectangle('Position',[0.59,0.35,3.75,1.37],...
%           'Curvature',[0.8,0.4],...
%          'LineWidth',2,'LineStyle','--')
   rectangle('Position',[x0,y0,W,H],'EdgeColor','G','LineWidth',2);
   drawnow ;
            
            WriterObj.writeVideo(getframe(figure(100))) ;
            
   %......................DWT...................................
   GetSubspaceFeatureVector_DWT_mod(T_Org_Gray,wavelet_type);
   x=x0;
   y=y0;
   position = [x0,y0];
            corner_list = [x0, y0, W, H] ;
             time0 = tic;
              bplot = 1 ;
                corner_list = [corner_list; x, y, W, H] ;
   %............................................................
    else
   [ x,y,bplot ] = GetNewPositionBy_DWT_mod(handles,frame,x,y,H,W,T_Org,wavelet_type);
   position = [x,y];
                corner_list = [corner_list; x, y, W, H] ;
                time_elapsed = [time_elapsed, toc(time0)];
    
   if bplot==1
       Tfrno=frno-frameno+1;
       trackInfo(Tfrno,1)=frno;
       trackInfo(Tfrno,2)=x+0.5*W;
       trackInfo(Tfrno,3)=y+H;
       
       T_Gray=rgb2gray(T);
        I=T_Gray;
        level = graythresh(I);
        BW = im2bw(I,level);
        %imshow(BW,'parent',handles.axes1);
    
   rectangle('Position',[x,y,W,H],'EdgeColor','G','LineWidth',2);
   drawnow ;
   img_write = getframe(figure(100));
    WriterObj.writeVideo(img_write);
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
        
        delete(Videoobj);
        break;
    end
    
    toc
end
delay = toc;
dlmwrite('tracked_cornersdwt.txt', corner_list) ;
mean_delay = delay / frame_count;
dlmwrite('fastpf_result.txt', corner_list) ;
temp = ['Mean Computation Time per frame : ', num2str(mean_delay)] ;

% temp = ['Mean Computation Time per frame : ', num2str(mean(time_elapsed)/2)] ;
disp(temp);
tElapsed=toc(tstart);
figure(10);
X_cords=trackInfo(:,2);
Y_cords=rows-trackInfo(:,3);
plot(X_cords(2:length(X_cords)),Y_cords(2:length(Y_cords)));
axis([0 cols 0 rows]);
text(X_cords(2)+10,Y_cords(2)+10,'A');
text(X_cords(numel(X_cords))+10,Y_cords(numel(Y_cords))+10,'B');
title(strcat('Tracked Object Path','Time Elapsed=',num2str(tElapsed)));
%movie(hf, mov, 1, FrameRate);
end

