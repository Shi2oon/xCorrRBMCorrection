function [ ReferenceImage ] = loadReferenceImage( )
%LOADREFERENCEIMAGE Loads single .tif image into workspace.
%   This function prompts the user to select a single .tif image which will
%   be used as the reference image in the movement correction process. The
%   selected image should be an 8-bit (greyscale) .tif.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 22nd December 2017
%
% Outputs
%   - Struct: 'ReferenceImage' containing
%       - Char: 'filename' e.g. 'Image001.tif'
%       - Char: 'pathname' e.g. 'C:\Documents'
%       - m x n uint8: 'image' containing image data. m = vertical height
%       of image, n = horizontal width of image.

% User selects file
fprintf('Select reference image:\n')
[filename, pathname] = uigetfile( ...
    {'*.tif','*.tiff'}, ...
    'Select Reference Image');
if isequal(filename,0)
    error('User selected Cancel')
else
    disp(['User selected ', fullfile(filename), ...
        ' as reference image.'])
end

% Read image data from .tif file
im = imread(fullfile(pathname,filename),'tif');
if size(im,3)>1;        im=mean(im,3)/255;      end % 3 layerd images

% Populate ReferenceImage struct
ReferenceImage.filename = filename;
ReferenceImage.pathname = pathname;
ReferenceImage.image = im;
end

