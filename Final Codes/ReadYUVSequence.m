function [ yuv ] = ReadYUVSequence( SequencePath,w,ht )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
yuv=[];
fcr=0.5;
fcb=0.5;
         %get Filesize and TotalFrames
    Seq_p = dir(SequencePath); 
    SeqBytes = Seq_p.bytes; %Filesize
    clear filep
    Totalframes = SeqBytes/(w*ht*(1+2*fcr*fcb));
    if mod(Totalframes,1) ~= 0
        msgbox('Error: wrong resolution, format or filesize');
    else
        h = waitbar(0,'Please wait ... ','Name','Reading YUV Sequence File...');
        %read YUV-Frames
        for i = 1:1:Totalframes
            waitbar(i/Totalframes,h);
            sYUV = loadYUVSequence(w,ht,i,SequencePath,fcr,fcb);
            RGB = ycbcr2rgb(uint8(sYUV)); %Convert YUV to RGB
            yuv(i).cdata = RGB;
            yuv(i).colormap = [];
        end
        close(h);
    end


%end
% loadFileYUV(width,height,Frame_Number,File,fcr,fcb)
function YUV = loadYUVSequence(width,height,Frame,fileName,fcr,fcb)
    % get size of U and V
    fileId = fopen(fileName,'r');
    width_h = width*fcb;
    height_h = height*fcr;
    % compute factor for framesize
    factor = 1+(fcr*fcb)*2;
    % compute framesize
    framesize = width*height;
      
    fseek(fileId,(Frame-1)*factor*framesize, 'bof');
    % create Y-Matrix
    YMatrix = fread(fileId, width * height, 'uchar');
    YMatrix = int16(reshape(YMatrix,width,height)');
    % create U- and V- Matrix
    
        UMatrix = fread(fileId,width_h * height_h, 'uchar');
        UMatrix = int16(UMatrix);
        UMatrix = reshape(UMatrix,width_h, height_h).';
        
        VMatrix = fread(fileId,width_h * height_h, 'uchar');
        VMatrix = int16(VMatrix);
        VMatrix = reshape(VMatrix,width_h, height_h).';       
    
    % compose the YUV-matrix:
    YUV(1:height,1:width,1) = YMatrix;
    
    
   
         
        UMatrix1(1:height_h,1:width) = int16(0);
        UMatrix1(1:height_h,1:2:end) = UMatrix(:,1:1:end);
        UMatrix1(1:height_h,2:2:end) = UMatrix(:,1:1:end);
 
        VMatrix1(1:height_h,1:width) = int16(0);
        VMatrix1(1:height_h,1:2:end) = VMatrix(:,1:1:end);
        VMatrix1(1:height_h,2:2:end) = VMatrix(:,1:1:end);
      
   
    
       
        
        YUV(1:height,1:width,2) = int16(0);
        YUV(1:2:end,:,2) = UMatrix1(:,:);
        YUV(2:2:end,:,2) = UMatrix1(:,:);
        
        YUV(1:height,1:width,3) = int16(0);
        YUV(1:2:end,:,3) = VMatrix1(:,:);
        YUV(2:2:end,:,3) = VMatrix1(:,:);
        
    
   
    sYUV = uint8(YUV);
    fclose(fileId);

