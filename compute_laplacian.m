function [ L ] = compute_laplacian( W, type )
%COMPUTE_LAPLACIAN Computes graph laplacian
%   COMPUTE_LAPLACIAN( W, TYPE ) computes the graph laplacian of the
%   affinity matrix W, in the form specified by TYPE.

offset = .001; % For regularization. Setting this larger than 0 causes the 
% first eigen value not to be 0.

D = spdiags(sum(W,2) + offset, 0, length(W), length(W));
if type == 1
    Dinvsqrt = 1 ./ sqrt(D);
    Dinvsqrt(~logical(diag(diag(Dinvsqrt)))) = 0;
    C = (D - W) * Dinvsqrt;
    L = sparse(Dinvsqrt * C);   
elseif type == 2
    Dinvsqrt = 1 ./ sqrt(D);
    Dinvsqrt(~logical(diag(diag(Dinvsqrt)))) = 0;
    C = W * Dinvsqrt;
    L = sparse(Dinvsqrt * C); 
elseif type == 3
    Dinv = 1 ./ D;
    Dinv(~logical(diag(diag(Dinv)))) = 0;
    C = (D - W) * Dinv;
    L = sparse(Dinv * C); 
elseif type == 4
    Dinv = inv(D);
    L = Dinv*sparse(D-W);
else
    L = sparse(D - W);
end


