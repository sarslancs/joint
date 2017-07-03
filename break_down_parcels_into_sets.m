function [ set ] = break_down_parcels_into_sets( labels, nSubjects, nVertices )
%BREAD_DOWN_PARCELS_INTO_SETS Given a vector of labels, construct a
%column-wise matrix of nVerices x nSubjects

    set = [];
    for i = 1 : nSubjects
        set = [set labels(nVertices*(i-1)+1:nVertices*i)];
    end

end

