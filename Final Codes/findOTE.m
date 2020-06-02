function [ote,frame_error,trdr,far] = findOTE(window1,window2)
ground_truth = window1;
detected_data = window2 ;

W = max(ground_truth(1,3),detected_data(1,3));
H = max(ground_truth(1,4),detected_data(1,3));

tp = 0 ;
fp = 0 ;
threshold = 0.5;
for i = 1 : size(ground_truth,1)
    if((abs(ground_truth(i,1)-detected_data(i,1)) > (threshold * W)) || (abs(ground_truth(i,2)-detected_data(i,2)) > (threshold*H))) 
        fp = fp + 1 ;
    else
        tp = tp + 1 ;
    end
end

trdr = tp / size(ground_truth,1);

far = fp / (fp + tp);

ote = 0 ;
for i = 1 : size(ground_truth,1)
    ote = ote + (ground_truth(i,1)-detected_data(i,1))^2 + (ground_truth(i,2)-detected_data(i,2))^2 ;
end

ote = sqrt(ote) / size(ground_truth,1);

for i = 1 : size(ground_truth,1)
    err_fr(i) = sqrt((ground_truth(i,1)-detected_data(i,1))^2 + (ground_truth(i,2)-detected_data(i,2))^2) ;
end
frame_error = err_fr;