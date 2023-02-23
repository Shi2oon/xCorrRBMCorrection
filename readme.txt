% xCorrRBMCorrection.m
%
% MATLAB program to remove translational rigid body movements from image
% sequences. This can improve the accuracy of subsequent DIC analysis.
% Generates a sequence of corrected images where each original image has
% been cropped to the area defined as the effecive intersection of the
% original images.
%
% Written by Phil Earp and updated by Abdo Koko as part of DPhil project at University of Oxford.
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
