function [EigenValues, EigenVectors] = sort_eigenvalues(EigenValues,EigenVectors)
%SORT_EIGENVALUES Sort eigen values in descending order

[sorted_val,ind] = sort(diag(EigenValues));
EigenVectors = EigenVectors(:,ind);
EigenValues = sorted_val;