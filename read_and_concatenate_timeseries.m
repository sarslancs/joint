function [ dtseries ] = read_and_concatenate_timeseries( subjectID, hem )
%READ_AND_CONCATENATE_TIMESERIES Load HCP timeseries from disk and  
%   temporally concatenate timeseries of 4 different scans for each
%   subject.

%% Set input/output directories
readFrom = ['/vol/vipdata/data/HCP100/' subjectID ...
            '/functional/rest/denoised/MNINonLinear/Results/'];
% Please set the directory the rsfMRI timeseries files will be read from.

%% Load data
fileName = [readFrom '/rfMRI_REST1_LR/rfMRI_REST1_LR_Atlas_hp2000_clean.dtseries.nii'];
dtseries = read_cifti(fileName);
dtseries1_LR = get_cortical_timeseries( dtseries, hem );

fileName = [readFrom '/rfMRI_REST1_RL/rfMRI_REST1_RL_Atlas_hp2000_clean.dtseries.nii'];
dtseries = read_cifti(fileName);
dtseries1_RL = get_cortical_timeseries( dtseries, hem );

fileName = [readFrom '/rfMRI_REST2_LR/rfMRI_REST2_LR_Atlas_hp2000_clean.dtseries.nii'];
dtseries = read_cifti(fileName);
dtseries2_LR = get_cortical_timeseries( dtseries, hem );

fileName = [readFrom '/rfMRI_REST2_RL/rfMRI_REST2_RL_Atlas_hp2000_clean.dtseries.nii'];
dtseries = read_cifti(fileName);
dtseries2_RL = get_cortical_timeseries( dtseries, hem );

% Normalize to zero-mean and unit-variance before concatenating 
dtseries1_LR = zscore(dtseries1_LR',[],1)'; 
dtseries1_RL = zscore(dtseries1_RL',[],1)'; 
dtseries2_LR = zscore(dtseries2_LR',[],1)'; 
dtseries2_RL = zscore(dtseries2_RL',[],1)'; 

% Temporal concatenation
dtseries = [dtseries1_LR dtseries1_RL dtseries2_LR dtseries2_RL];




