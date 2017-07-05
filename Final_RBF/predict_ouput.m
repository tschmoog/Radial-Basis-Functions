function [ predicted_output] = predict_ouput(input_vector, neurons, beta, weights )
%The function returns a predicted output given an input vector


%Betas all same value, for each neuron
betas = ones(size(neurons,1),1) * beta;


%Calculate activations given input 
activation = calc_activation( neurons, betas, input_vector );
%Calculate weights possibly?

%For each neuron one must multiply weights by activations
predicted_output = weights'*activation;


end

