function [ parcels, stability ] = majority_voting_on_sets( set, nVertices )
%MAJORITY_VOTING_ON_SETS Apply majority voting to a set 
%(output of break_down_parcels_into_sets)

stability = zeros(nVertices,1);
for i = 1 : length(set)
    [ uniqs, counts ] = countUniqueElements( set(i,:)' );
    stability(i) = 1 / length(uniqs);
    if counts(1) < size(set,2)            
        set(i,:) = ones(1,size(set,2)) * uniqs(1);
    end
end
parcels = set(1:nVertices,1);
