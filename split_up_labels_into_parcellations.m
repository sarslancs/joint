function [ set ] = split_up_labels_into_parcellations( L, nSubjects, nVertices )
%SPLIT_UP_LABELS_INTO_PARCELLATIONS Divides labels vector
%   [ SET ] = SPLIT_UP_LABELS_INTO_PARCELLATIONS( L, nSUBJECTS, NVERTICES)
%   divides the groupwise label vector L into nSUBJECTS sequential sub-
%   vectors of lenghth NVERTICES. A simple majority voting accross the
%   single parcellations can then be used to generate the group
%   parcellation.

    set = [];
    for i = 1 : nSubjects
        set = [set L(nVertices*(i-1)+1:nVertices*i)];
    end

end

