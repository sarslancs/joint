function [ Xs, Ys ] = spectral_ordering( X, Y, num )
%SPECTRAL_ORDERING Spectral ordering of the eigenvectors
%   SPECTRAL_ORDERING (re)orders the set of eigenvectors given in X and Y, 
%   simply based on their Euclidean distances. The function may flip
%   signs, as well as change the initial order of the eigenvectors. This
%   is a simpler but faster version of the algorithm described in the 
%   paper. NUM stands for the number of eigenvectors that will be kept
%   after applying spectral clustering. It is 8 by default, but can be
%   changed in the main script.

k = size(X,2);

pairs = zeros(k,1);

for i = 1 : k
    [id1, D1] = knnsearch(Y',X(:,i)');
    [id2, D2] = knnsearch(Y',-X(:,i)');
    if D1 < D2
        pairs(i,:) = id1;
    else
        pairs(i) = id2;
        X(:,i) = -X(:,i);
    end        
end

Xs = X(:,pairs > 0);
pairs(pairs == 0) = [];
Ys = Y(:,pairs);

if num
    Xs = Xs(:,1:num);
    Ys = Ys(:,1:num);
end

