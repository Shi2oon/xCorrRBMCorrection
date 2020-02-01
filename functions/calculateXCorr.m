function [ CrossCorrData] = calculateXCorr( ReferenceImage, TestImages )
%IMAGE_XC Calculate image shift from reference to test images.
%   This function uses the fourier-space cross-correlation function
%   dftregistration to calculate the shift in pixels from the reference
%   image to each test image. This is presented as the row and column
%   co-ordinates (in the reference image co-ordinate frame) which would
%   draw the test image in the correct position above the reference image.
%
%   For example, if the reference image must be shifted 10 pixels to the
%   left and 3 pixels down to register it on top of the test image, the
%   image shift will be (xShift,yShift) = (-10,-3). This is equivalent to a
%   shift (colShift,rowShift) = (-10,3) since the image rows are numbered
%   from the top of the image.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 29th December 2017
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
%       - 1 x a cell array of m x n uint8: 'imageArray' containing image data. m
%       = vertical height of image, n = horizontal width of image.
%       - 'nTestImages' number of images
% 
% Outputs
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
% Changelog
%   - 2017/12/29 added textprogressbar

% Define row and column co-ordinates for Reference image
% [1 2 3 ... nRows]
ReferenceImage.rows = int16(1:size(ReferenceImage.image,1));
% [1 2 3 ... nCols]
ReferenceImage.cols = int16(1:size(ReferenceImage.image,2));

fprintf(sprintf('%45s','Calculating FFT cross-correlation: '))
nTestImages = TestImages.nTestImages;
% Loop through Test images
for iTestImages = 1:nTestImages
    f = ReferenceImage.image;
    g = TestImages.imageArray{iTestImages};
    % An upscale_factor of 1 results in nearest pixel matching
    upscale_factor = 20;
    % Perform the image correlation between reference and test images
    [output, ~ ] = dftregistration(fft2(f),fft2(g),upscale_factor);
    % Populate CrossCorrData Struct
    CrossCorrData.rowShift{iTestImages} = int16(output(3));
    CrossCorrData.colShift{iTestImages} = int16(output(4));
    CrossCorrData.rows{iTestImages} = ...
        ReferenceImage.rows + CrossCorrData.rowShift{iTestImages};
    CrossCorrData.cols{iTestImages} = ...
        ReferenceImage.cols + CrossCorrData.colShift{iTestImages};
end
fprintf(' .. done\n')
% Extract co-ordinates of image overlap throughout image stack
[ CrossCorrData ] = ...
    calculateImageOverlap( CrossCorrData, ReferenceImage );

end

