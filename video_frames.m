clc; clear; close all
files=1:4;
ndd = {'1.4','1.5','1.6','1.7'};
dir='P:\Abdo\EBSD Data\19-11-31 InSitu DSS - Bone\load\CC\3. Corrected\New folder\';

out = fullfile(dir,'movie.avi'); %create directory
v = VideoWriter(out,'Motion JPEG AVI'); % Create a video object called animation
open(v); % Open the video
for frame=1:1:length(files) % Number of frames in the video
    file=[dir num2str(files(frame)) '.tif'];
    I = imread(file);
%     subplot(1,2,1); 
    imshow(I); title(['SE, Ext ' ndd{frame} 'mm'])
    
    file=[dir num2str(files(frame)) '.tif'];
    I = imread(file);
%     subplot(1,2,2); imshow(I); title(['FSE, Ext ' ndd{frame/2} '\mum'])
%     imshow(squeeze(I(:,:,1)))
set(gcf,'position',[345 140 1230 780]); axis image
    M(frame) = getframe(gcf); % save each plot frame in an array
%     if sum(size(M(frame).cdata) == size(M(1).cdata))~=3
%         J = imresize(I,[size(M(1).cdata,1) size(M(1).cdata,2)]);
%         imshow(J(:,:,1:3))
%         M(frame) = getframe(gcf); % save each plot frame in an array
%     end
    for ii=1:10   
        writeVideo(v,M(frame)) % Write the images stored in M to the video file.
    end
end
 close(v); close all % Close and save the vide
