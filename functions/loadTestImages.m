function [ TestImages ] = loadTestImages( cdl)
%LOADTESTIMAGES Loads test image(s) into workspace
%   This function prompts the user to select a .tif image (or multiple .tif
%   images) which will be used as the 'test' images in the movement
%   correction process. The selected images should be 8-bit (greyscale)
%   .tif.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 22nd December 2017
%
% Outputs
%   - Struct: 'TestImages' containing
%       - 1 x a cell array of Char: 'filenameArray'; a = number of images 
%       - Char: 'pathname'; e.g. 'C:\Documents' 
%       - 1 x n cell array of m x n uint8: 'imageArray' containing image 
%         data. m = vertical height of image, n = horizontal width of image
%       - 'nTestImages' number of images.

tmp = pwd;
cd(cdl);
% User selects test images
fprintf('Select test image(s):\n')
[filenameList, pathname] = uigetfile( ...
    {'*.tif','*.tiff'}, ...
    'Select Test Images', ...
    'Multiselect', 'on');
if isequal(filenameList,0)
    error('User selected Cancel')
else
    % Clean up return from uigetfile if only one file
    if ischar(filenameList)
        filenameList={filenameList}; % convert char string to cellstr
    end
    nTestImages = length(filenameList);
    disp(['User selected ', num2str(nTestImages), ...
        ' test images.'])
end


% Sequentially load test images from .tif files
for iTestImages = 1:nTestImages
    im = imread(...
        fullfile(pathname,filenameList{iTestImages}),'tif');
    if size(im,3)>1;        im=mean(im,3)/255;      end % 3 layerd images
    imageArray{iTestImages} = im;
end

% Populate TestImages struct
TestImages.filenameArray = filenameList;
TestImages.pathname = pathname;
TestImages.imageArray = imageArray;
TestImages.nTestImages = nTestImages;

cd(tmp);
end