[file,path] = uigetfile('*.avi');
vid = read(VideoReader([path,file]));
size(vid,4)