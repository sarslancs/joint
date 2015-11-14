function [ W ] = cellWW_to_sparse( WW, first, last )
%CELLWW_TO_SPARSE Combine matrices into a joint multi-layer graph
%   CELLWW_TO_SPARSE( WW, FIRST, LAST ) generates a multi-layer graph by
%   combining the agginity matrices stored in WW. FIRST and LAST indicates
%   the range (inclusive) within which the matrices will be taken from.

W = [];
for i = first : last    
    R = [];
    for j = first : last        
        R = [R WW{i,j}];        
    end        
    W = [W;R];
end

W = sparse(W);


