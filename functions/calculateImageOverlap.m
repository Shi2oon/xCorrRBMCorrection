function [ CrossCorrData ] = ...
    calculateImageOverlap( CrossCorrData, ReferenceImage)
%CALCULATEIMAGEOVERLAP Calculates overlap area for image stack
%   This functon calculates the co-ordinates (with respect to the
%   co-ordinate system of the reference image) of the area of intersection
%   of all of the images in the image stack.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 22nd December 2017
%
% Inputs
%   - Struct: 'CrossCorrData' containing (where a = number of images)
%       - 1 x a cell array of uint16: 'rowShift'
%       - 1 x a cell array of uint16: 'colShift'
%       - 1 x a cell array of 1 x m uint16: 'rows'
%         m = test image height. 
%         e.g. [rowShift+1 rowShift+2 ... rowShift+m]
%       - 1 x a cell array of 1 x m uint16: 'cols'
%         n = test image width.
%         e.g. [colShift+1 colShift+2 ... colShift+n]
%   - Struct: 'ReferenceImage' containing
%       - Char: 'filename' e.g. 'Image001.tif'
%       - Char: 'pathname' e.g. 'C:\Documents'
%       - m x n uint8: 'image' containing image data. m = vertical height
%       of image, n = horizontal width of image.
%   
% Outputs
%   - Struct: 'CrossCorrData' as above with following added:
%       - 1 x 2 int16 row vector 'rowLimits'
%         e.g. [1, 1714]
%       - 1 x 2 int16 row vector 'colLimtis'
%         e.g. [157, 2560]

% initialise working variables
rowsToKeep = ReferenceImage.rows;
colsToKeep = ReferenceImage.cols;

fprintf(sprintf('%45s','Calculating image overlap: '))

nTestImages = length(CrossCorrData.rows);
% Calculate image overlap
for iTestImages = 1:nTestImages % Loop through image stack
    % Calculate intersection of working variable with ith test image
    rowsToKeep = intersect(rowsToKeep,CrossCorrData.rows{iTestImages});
    colsToKeep = intersect(colsToKeep,CrossCorrData.cols{iTestImages});
end

% Populate CrossCorrData struct
CrossCorrData.rowLimits = [rowsToKeep(1) rowsToKeep(end)];
CrossCorrData.colLimits = [colsToKeep(1) colsToKeep(end)];

fprintf(' .. done\n')
end

