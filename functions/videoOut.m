function videoOut(TestImagespathname, TestImagesfilenameArray)
close all; fclose('all');
dir= [TestImagespathname 'Corrected\'];

out = fullfile(dir,'movie.avi'); %create directory
v = VideoWriter(out,'Motion JPEG AVI'); % Create a video object called animation
open(v); % Open the video
for frame=1:length(TestImagesfilenameArray) % Number of frames in the video
    file=fullfile(TestImagespathname, TestImagesfilenameArray{frame});
    I = imread(file);
    subplot(1,2,1);     imshow(I); 
    title([ 'Original: ' num2str(frame) ' out of ' num2str(length(TestImagesfilenameArray)) ])
    
    file=fullfile(dir, [TestImagesfilenameArray{frame} '_Corrected.tif']);
    I = imread(file);
    subplot(1,2,2);     imshow(I); 
    title([ 'Corrected: ' num2str(frame) ' out of ' num2str(length(TestImagesfilenameArray)) ])
set(gcf,'position',[345 140 1230 780]); axis image
    M(frame) = getframe(gcf); % save each plot frame in an array
    for ii=1:10   
        writeVideo(v,M(frame)) % Write the images stored in M to the video file.
    end
end
 close(v); close all % Close and save the vide
