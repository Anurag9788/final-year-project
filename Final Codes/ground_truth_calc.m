
clear all ;
close all ;
clc ;

[f,p] = uigetfile('*.*') ;

Videoobj=VideoReader([p,f]);
frame_no_start = input('Enter starting frame no : ') ;
frame_no = frame_no_start ;

frame = read(Videoobj,frame_no);
figure;
imshow(frame);
title ('Select Object') ;
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected

load W ;
load H ;
corner_list = [W, H; point1(1,1), point1(1,2)] ;

frame_no = frame_no + 1 ;
while(frame_no < Videoobj.numberOfFrames)
    frame = read(Videoobj,frame_no);
    imshow(frame);
    title(['Frame number ', num2str(frame_no)]);
    k = waitforbuttonpress;
    point1 = get(gca,'CurrentPoint')    % button down detected
    corner_list = [corner_list; point1(1,1), point1(1,2)] ;
    frame_no = frame_no + 1 ;
end

dlmwrite('ground_truth.txt', corner_list);
close all ;
% fp = open('ground_truth.txt') ;
% fp.write(corner_list) ;
% fp.close() ;
