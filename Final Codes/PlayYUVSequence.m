function PlayYUVSequence( handles,fullpath,type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 if ~isempty(fullpath)
        
     i=get(handles.popupmenu1,'value');
    switch i
        case 1
        case 2
        width=176;
        height=144;
        
        case 3
        width=352;
        height=288;
    end
nFrames=str2double(get(handles.text7,'string'));
mov = ReadYUVSequence(fullpath,width,height);
vidHeight=height;
vidWidth=width;
if type==1

% Preallocate movie structure.
%mov(1:nFrames) = ...
%    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
%           'colormap', []);

% Read one frame at a time.
%for k = 1 : nFrames
%    mov(k).cdata = read(vidObj, k);
   % frame=uint8(mov(k).cdata);
    %imshow(frame,'parent',handles.axes2);
    %pause(0.1);
%end
%hf=handles.axes1;
% Size a figure based on the video's width and height.
hf = figure;
set(hf, 'position', [150 150 vidWidth vidHeight])

% Play back the movie once at the video's frame rate.
Framerate=15;
movie(hf, mov, 1, Framerate);
end
%..................................Gray..............
if type==2
%mgIFile=frame2im(yuv(imgINumber));

%mov(i).cdata = RGB;
%            yuv(i).colormap = [];
% Preallocate movie structure.
%mov1(1:nFrames) = ...
%    struct('cdata', zeros(vidHeight, vidWidth, 3, 'double'),'colormap',[]);
          
hf = figure;
set(hf, 'position', [500 500 vidWidth vidHeight])
% Read one frame at a time.
for k = 1 : nFrames
   
    frame=rgb2gray(frame2im(mov(k)));
    %mov1(k).cdata =uint8(frame);
    %mov1(k).colormap=map;
   %mov(1:nFrames) = ...
%    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
%           'colormap', []);
    imshow(frame,hf);
    pause(0.03);
 
end
 % Framerate=15;
%movie(hf, mov1,1, Framerate);
%hf=handles.axes1;
% Size a figure based on the video's width and height.
%hf = figure;
%set(hf, 'position', [150 150 vidWidth vidHeight])

% Play back the movie once at the video's frame rate.
%Framerate=15;
%movie(hf, mov, 1, Framerate);
end

 end


end

