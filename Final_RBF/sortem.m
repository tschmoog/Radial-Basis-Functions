function [P2,D2]=sortem(P,D)
% Function takes in two matracies (eigenvalues and eigenvectors) and
% returns them with the eigenvalues in descending order and the
% corresponding eigenvectors in the same order. 

D2=diag(sort(diag(D),'descend')); % make diagonal matrix out of sorted diagonal values of input D
[c, ind]=sort(diag(D),'descend'); % store the indices of which columns the sorted eigenvalues come from
P2=P(:,ind); % arrange the columns in this order
end
