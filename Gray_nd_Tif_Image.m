fname = {'1400','1500','1600','1700'};
pathname = 'P:\Abdo\EBSD Data\19-11-31 InSitu DSS - Bone\load\CC';
mkdir([ pathname '\Grayed']);
for iTestImages = 1:length(fname)
    imageFullpath = fullfile(pathname,fname{iTestImages});
    RGB = imread([imageFullpath '.bmp']);
%     imshow(RGB)
    I = rgb2gray(RGB);
%     figure
%     imshow(I)
    imageFilename = ['Grayed\' fname{iTestImages} '_Grayed.tif'];
    imageFullpath = fullfile(pathname,imageFilename);
    imwrite(I,imageFullpath);
end