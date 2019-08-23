function [ ] = writeImages( TestImages, CorrectedImages )
%WRITEIMAGES Writes movement-corrected images to file 
%   The movement-corrected images are written to in a sub-directory
%   'Corrected' of the directory the selected test images reside in.
%   Filenames are identical to the original test images with the addition
%   of the suffix '_Corrected'.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 29th December 2017
%
% Inputs
%   - Struct: 'TestImages' containing
%       - 1 x a cell array of Char: 'filenameArray'; a = number of images
%       - Char: 'pathname'; e.g. 'C:\Documents'
%       - 1 x a cell array of m x n uint8: 'imageArray' containing image
%         data. m = vertical height of image, n = horizontal width of image
%       - 'nTestImages' number of images
%   - Struct 'CorrectedImages'
%     (a = number of test images)
%     (p = height of corrected images)
%     (q = width of corrected images)
%       - 1 x a cell array of p x q uint8: 'imageArray'
%         Contains movement-corrected images
%       - 1 x a cell array of 1 x p int16: 'rowsArray'
%         row indices e.g. [1 2 3 ... image_height]
%       - 1 x a cell array of 1 x q int16: 'colsArray'
%         column indices e.g. [1 2 3 ... image_width]
%
% Changelog
% 2017/12/29 - Added if-statement to create output folder 'Corrected'

% Identify file names and file path
filenameArray = TestImages.filenameArray;
pathname = TestImages.pathname;

% Create folder called 'Corrected'
if exist([pathname 'Corrected'],'dir') == 0
    mkdir(pathname,'Corrected');
end

textprogressbar(sprintf('%45s','Writing images to file: '))
textprogressbar(0)

nTestImages = TestImages.nTestImages;
% Loop through images and write them to file
for iTestImages = 1:nTestImages 
    imageFilename = ['Corrected\'...
        filenameArray{iTestImages} '_Corrected.tif'];
    imageFullpath = fullfile(pathname,imageFilename);
    imwrite(CorrectedImages.imageArray{iTestImages},imageFullpath); 
    textprogressbar((iTestImages/nTestImages)*100)
end
textprogressbar('done')
end

