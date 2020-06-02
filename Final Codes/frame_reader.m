
clear all ;
close all ;
clc ;

[p,f] = uigetfile('*.*') ;

Videoobj=VideoReader([f,p]);
frame_no = 1 ;

while(1)
    frame_no = input('Enter the frame number (enter 0 to end) : ');
    if (frame_no == 0)
        break;
    end
    frame = read(Videoobj,frame_no);
    figure;
    imshow(frame);
    title(['Frame number ', num2str(frame_no)]);
end
    