function Staticbackgroundsubtraction(handles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global FilePath bStop;
Videoobj=VideoReader(FilePath);
nFrames=Videoobj.numberOfFrames;
VideoHeight=Videoobj.Height;
VideoWidth=Videoobj.Width;

%preallocate movie structure
% mov(1:nFrames)=...
%     struct('cdata',zeros(VideoHeight,VideoWidth,3,'uint8'),...
%     'colormap',[]);

% read one frame at a time

%bgframe=imread('ShoppingMall1202.bmp');

% for k=1:nFrames
%     mov(k).cdata=read(Videoobj,k);
% end
%hf=figure;
%set(hf,'position',[150 150 VideoWidth VideoHeight])


fr1=read(Videoobj,1);
%Imgfr1=uint8(fr1);
%imshow(Imgfr);
hf=figure(100);
fr1gray=rgb2gray(fr1);
%fr1gray=rgb2gray(bgframe);
for k=2:nFrames
    if bStop==1
    frk=read(Videoobj,k);
    %Imgfrk=uint8(frk);
    frkgray=rgb2gray(frk);
    I=imabsdiff(fr1gray,frkgray);
    level = graythresh(I);

    BW = im2bw(I,level);
    
    BW=bwmorph(BW,'bridge');
    
    BW=imfill(BW,'holes');
    
    se = strel('disk',9);
    
    BW=imclose(BW,se);
    BW=imopen(BW,se);
    BW=imclose(BW,se);
    %imshow(BW)

    %Imgfr=uint8(fr_bg);
    %imshow(imgdiff1k);
    
    %...............................
    bw=BW;
    %cc = bwconncomp(bw, 18);
    %objdata = regionprops(cc, 'basic');
   %.....................
   % obj_areas = [objdata.Area];
    
    labeledImage = bwlabeln(bw, 18); 
    blobMeasurements = regionprops(labeledImage, bw, 'all');   
    %numberOfBlobs = size(blobMeasurements, 1);
    allBlobAreas = [blobMeasurements.Area];
    allowableAreaIndexes = allBlobAreas > 1800; % Take the small objects.
    
    keeperIndexes = find(allowableAreaIndexes); 
    keeperBlobsImage = ismember(labeledImage, allowableAreaIndexes); 
    % Re-label with only the keeper blobs kept.
    labeledDimeImage = bwlabeln(keeperBlobsImage, 18);   
   %.......................
  % imshow((I*255),'parent',handles.axes4); 
   %imshow((BW*255),'parent',handles.axes5); 
    imshow(bw);
    %imshow(frk);
      hold on
    for i=1:length(keeperIndexes)
     rectangle('Position',blobMeasurements( keeperIndexes(i)).BoundingBox, ...
        'EdgeColor','y');
    
    end
    
    %...............................
    
    drawnow();
    else
        break;
    end
end

end