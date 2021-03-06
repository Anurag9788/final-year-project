clc ;
close all ;
clear all ;

[fg, pg] = uigetfile('*.txt', 'Select ground truth data') ;
ground_truth = dlmread([pg, fg]) ;

[fd, pd] = uigetfile('tracked_cornersdwt.txt', 'Select detected data') ;
detected_data = dlmread([pd, fd]) ;

W = ground_truth(1,1);
H = ground_truth(1,2);
ground_truth(1,: )= [] ;

tp = 0 ;
fp = 0 ;
for i = 1 : size(ground_truth,1)
    if(((ground_truth(i,1)-detected_data(i,1)) > (0.85 * W)) || ((ground_truth(i,2)-detected_data(i,2)) > (0.85*H))) 
        fp = fp + 1 ;
    else
        tp = tp + 1 ;
    end
end

trdr = tp / size(ground_truth,1) 

far = fp / (fp + tp) 

ote = 0 ;
for i = 1 : size(ground_truth,1)
    ote = ote + (ground_truth(i,1)-detected_data(i,1))^2 + (ground_truth(i,2)-detected_data(i,2))^2 ;
end

ote = sqrt(ote) / size(ground_truth,1)

for i = 1 : size(ground_truth,1)
    err_fr(i) = sqrt((ground_truth(i,1)-detected_data(i,1))^2 + (ground_truth(i,2)-detected_data(i,2))^2) ;
end
plot(err_fr) ;
xlabel('Frame No') ;
ylabel('MSRE') ;