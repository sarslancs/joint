function [ W, dtseries ] = compute_spatially_constrained_correlation_matrix( subjectID, hem )
%COMPUTE_SPATIALLY_CONSTRAINED_CORRELATION_MATRIX Computes the correlation
%   matrix. 
%   For a given SUBJECTID and HEMisphere, the spatially constrained
%   affinity (adjacency) matrix W is computed by correlating timeseries. 
%   A constraint is applied and correlations are computed for only 
%   spatially adjacent nodes. This ensures spatial contiguity in clusters 
%   and reduces computational overhead. The set of timeseries is returned  
%   in DTSERIES.

%% Set input/output directories and variables
readFrom = ['/vol/vipdata/data/HCP100/' subjectID ...
            '/structural/MNINonLinear/fsaverage_LR32k/'];
% Please set this to your local directory from which the files will be read.

% Determine the number of vertices across the hemisphere
if hem == 'L'
    numVertices = 29696;
else
    numVertices = 29716;   
end

% Matrix for storing temporary correlations
corr_map = zeros(numVertices, numVertices);

%% Load surface files
fileName = [subjectID '.' hem '.midthickness.32k_fs_LR.surf.gii'];
g = gifti([readFrom fileName]);  
vGray = g.vertices;
fGray = g.faces;

fileName = [subjectID '.' hem '.atlasroi.32k_fs_LR.shape.gii'];
g = gifti([readFrom fileName]);  
corticalMask = g.cdata;

% Mappers
[ map32to29, map29to32 ] = cortical_mappers(corticalMask);

%% Compute the adjacency neighbourhood matrix
[ adj, ~ ] = compute_vertex_nhood( vGray, fGray ); 

%% Load HCP timeseries data
dtseries = read_and_concatenate_timeseries( subjectID, hem );

%% Compute the spatially constrained correlation matrix
for j = 1 : length(dtseries)
    selected = dtseries(j, :);
    idx = nonzeros(map32to29(adj(map29to32(j),:) > 0));
    sv_series = dtseries(idx,:);
    cc = corr(selected', sv_series');
    cc(cc < 0 | cc >= 1) = 0;
    vect = zeros(1,length(dtseries));
    vect(idx) = cc;
    corr_map(j,:) = vect;
end

W = sparse(double(corr_map));


