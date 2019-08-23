function [ CorrectedImages ] = generateCorrectedImages(...
    TestImages, CrossCorrData )
%GENERATECORRECTEDIMAGES Extracts overlapping regions from test images
%   This function extracts the region from each test image corresponding to
%   the 'overlap area' of the image stack to generate a new 'Corrected'
%   stack of images. 
%   
%   (The 'overlap area' is the region identified in the
%   calculateImageOverlap function and is defined by the rowLimits and
%   colLimits in the CrossCorrData struct. It describes the image region
%   common to all the images in the stack.)
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
%   - Struct: 'CrossCorrData' containing (where a = number of images)
%       - 1 x a cell array of uint16: 'rowShift'
%       - 1 x a cell array of uint16: 'colShift'
%       - 1 x a cell array of 1 x m uint16: 'rows'
%         m = test image height.
%         e.g. [rowShift+1 rowShift+2 ... rowShift+m]
%       - 1 x a cell array of 1 x m uint16: 'cols'
%         n = test image width.
%         e.g. [colShift+1 colShift+2 ... colShift+n]
%       - 1 x 2 int16 row vector 'rowLimits' specifying overlap area
%         e.g. [1, 1714]
%       - 1 x 2 int16 row vector 'colLimtis' specifying overlap area
%         e.g. [157, 2560]
%
% Outputs
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
%   - 2017/12/29 added textprogressbar

nTestImages = TestImages.nTestImages;

textprogressbar(sprintf('%45s','Generating movement-corrected images: '))
textprogressbar(0)

for iTestImages = 1:nTestImages % Loop through each test image
    % Find columns in ith test image which lie in overlap region
    colsToSelect = find(and(...
        CrossCorrData.cols{iTestImages} >= min(CrossCorrData.colLimits), ...
        CrossCorrData.cols{iTestImages} <= max(CrossCorrData.colLimits)));
    % Find rows in ith test image which lie in overlap region
    rowsToSelect = find(and(...
        CrossCorrData.rows{iTestImages} >= min(CrossCorrData.rowLimits), ...
        CrossCorrData.rows{iTestImages} <= max(CrossCorrData.rowLimits)));
    
    % Generate new image. This image is the subset of the ith test image
    % which lies in the overlap region.
    CorrectedImages.imageArray{iTestImages} = ...
        TestImages.imageArray{iTestImages}... % from ith test image...
        (min(rowsToSelect):max(rowsToSelect), ... % ...select rows...
        min(colsToSelect):max(colsToSelect)); % ...and select cols
    textprogressbar(0.5*(iTestImages/nTestImages)*100) % [0% - 50%]
end

% Calculate size of corrected  images (all images in stack have same
% dimensions)
correctedImageSize = size(CorrectedImages.imageArray{1});

% Generate rows and cols indices for corrected images (identical for all
% images in stack)
for iTestImages = 1:nTestImages
    CorrectedImages.rowsArray{iTestImages} = ...
        int16(1:correctedImageSize(1));
    CorrectedImages.colsArray{iTestImages} = ...
        int16(1:correctedImageSize(2));
    textprogressbar(50+(0.5*(iTestImages/nTestImages)*100)) % [50% - 100%]
end
textprogressbar('done')
end

