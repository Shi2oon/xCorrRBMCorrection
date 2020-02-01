%tool to convert image files
clc; clear; close all
format compact

%%
%input the input and output directories
%location of the images, make sure they are all *.tif files ONLY
imagefolder='P:\Abdo\EBSD Data\19-11-31 InSitu DSS - Bone\load\CC\Grayed';
%the output dir; make this somewhere new
desfolder='P:\Abdo\EBSD Data\19-11-31 InSitu DSS - Bone\load\CC\Grayed\16 bits';

interval =10;
%%
%makes the destfolder if it doesn't exist already
if ~exist(desfolder)
    mkdir(desfolder);
end

%find all the images in the imagefolder
% images=ls(imagefolder,'.tif');
images = dir(fullfile(imagefolder,'/*.tif'));

%find out the number of images in the dir
numberofimages=size(images,1)
tic
j=0;
n=0;

for j=1:1
    cur_file = fullfile(imagefolder,images(j).name);
    tmpImage=double(imread(cur_file));
    tmpImage2 = tmpImage-min(tmpImage(:));
    tmpImage2 = tmpImage2./max(tmpImage2(:));
    tmpImage2 = uint16(tmpImage2.*(2^16-1));
    
%     imshow(tmpImage2)
%     disp 'Select top left point of rectangular ROI'
%     [x1,y1] = ginput(1);
        x1 = 1; y1=1;
%     disp 'Select bottom right point of rectangular ROI'
% [~,y2] = ginput(1);
%     gcf, close
       x2=size(tmpImage,2);  y2=size(tmpImage,1)-10;
%     ROI = tmpImage(y1:y2,x1:x2);        %NOT tmpImage2
	ROI = tmpImage;        %NOT tmpImage2
            
    minInt = double(min(ROI(:)));
    maxInt = double(max(ROI(:)-minInt));
end

for j=1:numberofimages
    cur_file = fullfile(imagefolder,images(j).name);
    tmpImage=double(imread(cur_file));

    tmpImage = tmpImage-minInt;
    tmpImage = tmpImage./maxInt;
    tmpImage = uint16(tmpImage.*(2^16-1));

    imwrite(tmpImage,fullfile(desfolder, images(j).name),'tif','compression','none');
    
    disp(num2str(j/numberofimages*100,'%2.0f'));
end

disp(['Finished in ' num2str(toc) 's'])

imshow(tmpImage)
hold on
ROIrect = [x1,y1;x2,y1;x2,y2;x1,y2;x1,y1];
plot(ROIrect(:,1), ROIrect(:,2),'c-')