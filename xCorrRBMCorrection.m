% xCorrRBMCorrection.m
%
% MATLAB program to remove translational rigid body movements from image
% sequences. This can improve the accuracy of subsequent DIC analysis.
% Generates a sequence of corrected images where each original image has
% been cropped to the area defined as the effecive intersection of the
% original images.
%
% Written by Phil Earp as part of DPhil project at University of Oxford.
% philip.earp@stcatz.ox.ac.uk
%
% Last updated and tested 29th December 2017
%
% User will be asked to select:
% a) Reference image (8-bit .tif)
% b) Test image(s)   (8-bit .tif)
%
% Corrected images are saved with filename
% "<OriginalFileName>_Corrected.tif" in a sub-directory 'Corrected' of the
% directory the selected test images reside in.
%
% Results table containing the image shifts in pixels are saved into
% 'ResultsTable.csv'.
%
% Acknowledgements
%   - textprogressbar 
%     Copyright (c) 2010, Paul Proteus
%   - dftregistration from efficient_subpixel_registration
%     Copyright (c) 2016, Manuel Guizar Sicairos, James R. Fienup,
%     University of Rochester

clc; clear
addpath([pwd '\functions']);
addpath([pwd '\functions\textprogressbar']);
addpath([pwd '\functions\efficient_subpixel_registration']);

fprintf('Written by Phil Earp. philip.earp@stcatz.ox.ac.uk\n\n')

% Load images into workspace
[ ReferenceImage ] = loadReferenceImage( );
[ TestImages ] = loadTestImages(ReferenceImage.pathname);

% Peform cross-correlation
[ CrossCorrData ] = calculateXCorr( ReferenceImage, TestImages );

% Generate movement-corrected images
[ CorrectedImages ] = generateCorrectedImages( TestImages, CrossCorrData );

% Write corrected images to file
writeImages( TestImages, CorrectedImages );

% Write results table (containing image movements) to file
[ ResultsTable ] = writeResults( ...
    ReferenceImage, TestImages, CrossCorrData );

% video
videoOut(TestImages.pathname, TestImages.filenameArray);

fprintf('xCorrRBMCorrection completed successfully.\n')