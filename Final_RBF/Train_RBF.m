function [ betas, centre_locations, weights] = Train_RBF (sigma, K, training_input, training_output)

%Hyperparameters:

%K: The number of neurons 
%Sigma: A parameter that determines the width of the gaussian activation function 

%Compute beta from sigma
beta = 1./(2.*sigma.^2);
%Now the neural network can be trained
%Get data size
data_size = size(training_input, 1);


%K-means clustering is now performed

%==========================================
%K means
%==========================================

%Specify K

[index,centre_locations] = KMeansClus(K, training_input, 200);

%Beta coefficients for the network for each neuron. In classification
%problems, a beta value can be trained for each neuron in the hidden layer,
%however as this is a function aproximation problem, the same value of beta
%is used for each neuron:

betas = ones(size(centre_locations,1),1) * beta;


%Train output weights

%Number of output neurons 
neurons = size(centre_locations,1);

%Work out activation values for each neuron
%Holder matrix:
activations = zeros(data_size, neurons);

%For each training example get activations and store them

for i = 1:data_size
    input = training_input(i,:);
    
    %Calculate activation 
    activation = calc_activation(centre_locations, betas,input);
    
    %Store activation in matrix
    activations(i,:) = activation';
      
end

%Add bias to activations (a column of 1s)
activations = [ones(data_size,1), activations]; 


%Learn output weights

%Output weights are calculated using matrix inverse and psuedoinverse

weights = pinv(activations' * activations) * activations' * training_output;



end

