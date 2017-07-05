function [ output_args ] = calc_weights()
%This function calculates and returns the weights of the network.  

weights = pinv(activations' * activations) * activations' * training_output;


end

