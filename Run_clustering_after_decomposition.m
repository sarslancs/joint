%% Step 3: Run Clustering After Decomposition
% Now that you have decomposed the joint-graph into its eigen compoponets,
% you can feed this feature matrix into a clustering algorithm. Here, for
% its simplicity we only included the kmeans algorithm, but it may be
% replaced by any other, as kmeans has its own limitations.
%% Set parameters
hem             = 'L'; % Which hemisphere?
nVertices       = 29696; % Number of cortical vertices
subjects        = 1:1:20; % Subject numbers of the first set;
kMax            = 200; % Number of eigenvectors that will be kept for clustering
saveOutput      = 1; % Save the output matrix?
nSucjects       = length(subjects); % Number of total subjects
C               = 50; % Number of parcels
kMeansReplicate = 10; % Kmeans replicates 
kMeansMaxIter   = 500; % Kmeans max iteration
clusteringAlgo  = 1; % Run k-means

%% Get data prepared
% Load the EigenSets computed via Joint_spectral_decomposition
load(['EigenSets_' hem '.mat']);
    
eigenVectors = EigenSet.eigenVectors;
eigenValues = EigenSet.eigenValues;

[~, eigVectorsSorted] = sort_eigenvalues(eigenValues,eigenVectors);

eigVectorsSorted(:,1) = []; % Remove the first eigenvector, which provides 
% no information

%% Run clustering algorithm
if clusteringAlgo == 1
    [ labels, ~ ] =  kmeans(eigVectorsSorted(:,1:C), C, 'Display','final',... 
                         'Replicates', kMeansReplicate, 'MaxIter', kMeansMaxIter);
    singleParcelSet = break_down_parcels_into_sets( labels, nSucjects, nVertices );
    [ groupParcels, ~ ] = majority_voting_on_sets( singleParcelSet, nVertices );
else
    % Insert here your favourite clustering method. I would suggest you
    % might like the multiscale ncut implementation based on discretization
    % @ www.timotheecour.com/software/ncut_multiscale/ncut_multiscale.html
    % Discretization may have major advantages over k-means, it is faster
    % and less sensitive to initilazition. But expect to have less  
    % reproducible parcellations.
end




 