clc;
clear all;

ch = menu('Select ground truth source','CSV or Text file','MAT File');
[file,path] = uigetfile('*.*','Pick the ground truth');
if(ch == 1)
    gt = csvread([path,file]);
else
    load([path,file]);
    gt = results{1}.anno;
end
ch = menu('Select result source','CSV or Text file','MAT File');
[file,path] = uigetfile('*.*','Pick the result file');
if(ch == 1)
    result = csvread([path,file]);
else
    load([path,file]);
    result = results{1}.anno;
end

min_size = min(size(gt,1),size(result,1));

window1 = gt(1:min_size,:);
window2 = result(1:min_size,:);

obj_size = max(window1(1,3),window1(1,4)); %Width of object

[ote,frame_error,trdr,far] = findOTE(window1,window2);

str = sprintf('OTE:%0.04f, True Detection Rate:%0.04f %%, False Acceptance Rate:%0.04f %%\n',ote,trdr*100,far*100);
plot(frame_error);
title('Frame error');
xlabel('Frame number');
ylabel('Error');

accuracy = 0;
error_th = 5; %Error threshold
ote_frame = []; %Output tracking error vs frame number
for count=1:min_size
    val1 = gt(count,:);
    val2 = result(count,:);
    
    diff_val = abs(val1 - val2);
    diff_val = diff_val(:);
    len_val = length(find(diff_val >= error_th));
    
    ote = len_val / length(diff_val);
    ote_frame = [ote_frame ote];
    
    if(len_val == 0)
        accuracy = accuracy + 1;
    end
end
accuracy = accuracy * 100 / min_size;
menu(sprintf('Success Rate:%0.04f %%, overlap threshold:%0.04f',accuracy,error_th/obj_size),'Ok');

menu(str,'Ok');