function [ activation ] = calc_activation( centers, betas, input )
% Function calculates the activation values for RBF neuron given an input
% vector. 
%Calculate the distance between the input vector and centre 
diffs = bsxfun(@minus, centers, input);
%Square the distances from the centres, and sum along the column to give
%squared distance. 
sqrdDists = sum(diffs .^ 2, 2);
%Output activation is the 
activation = exp(-betas .* sqrdDists); %sqrdDists;
end

