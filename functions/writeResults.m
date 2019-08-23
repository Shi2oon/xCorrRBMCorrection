function [ ResultsTable ] = ...
    writeResults( ReferenceImage, TestImages, CrossCorrData )
%WRITERESULTS Summary Create results table and write to file
%   Generates a results table containing the image shifts found during the
%   cross-correlation procedure and writes them to a comma-separated file
%   called 'ResultsTable.csv' in the current directory.
%   
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 22nd December 2017
%
% Inputs
%   - Struct: 'ReferenceImage' containing
%       - Char: 'filename' e.g. 'Image001.tif'
%       - Char: 'pathname' e.g. 'C:\Documents'
%       - m x n uint8: 'image' containing image data. m = vertical height
%       of image, n = horizontal width of image.
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
%   - a x 4 table 'ResultsTable' containing field:
%       - ReferenceImage
%         Filename of reference image. e.g. 'image1.tif'
%       - TestImage
%         Filename of test image. e.g. 'image2.tif'
%       - ref2TestXShiftPixels
%         pixel shift in the horizontal directon required to shift the test
%         image into alignment with the reference image
%       - ref2TestXShiftPixels
%         pixel shift in the vertical directon required to shift the test
%         image into alignment with the reference image

ResultsTable = table(...
    cellstr(repmat(ReferenceImage.filename,TestImages.nTestImages,1)),...
    TestImages.filenameArray', ...
    CrossCorrData.colShift', ...
    CrossCorrData.rowShift');
ResultsTable.Properties.VariableNames = ...
    {'ReferenceImage' ...
    'TestImage' ...
    'ref2TestXShiftPixels' ...
    'ref2TestYShiftPixels'};

% Make x-shift correct for tracking equivalent point from ref --> test.
% Also convert x-shift values in table from cell --> int16
ResultsTable.ref2TestXShiftPixels = ...
    cellfun(@(x) x.*-1,ResultsTable.ref2TestXShiftPixels);
% Convert y-shift values in table from cell --> int16
ResultsTable.ref2TestYShiftPixels = ...
    cellfun(@(x) x.*1,ResultsTable.ref2TestYShiftPixels);

writetable(ResultsTable,'ResultsTable.csv')
end

