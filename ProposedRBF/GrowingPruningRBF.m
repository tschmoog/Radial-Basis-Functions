%This RBF grows and prunes neurons based on their calculated significance 

%Hyperparaneters:

%Approximation accuracy: Desired accuracy of the function
emin = 0.01;

%Episilon: Sets a threshold for growing and pruning neurons
epsilon_min = 0.01;
epsilon_max = 0.1;

%gamma is a decay paramater used to determine how neurons are added. 
%Neurons will be added quickly, and less will be added as gamma causes the
%growth function to 'decay'
gamma = 0.9999;

%sigma and beta for manipulatig the width of neurons 
sigma = 5;
%Compute beta from sigma
beta = 1./(2.*sigma.^2);

%Variable holding size of traning data
data_size = length(training_input);
%Network begins with 0 neurons.
%Initialise empty matrix to hold neurons
neurons = [0,0,0,0,0,0,0,0,0,0];
%Weights
weights = [0];
%Activations 
activations = [0];

%Initialise parameters for EKF to update
EK_State_Estimate =[];
EK_Error_Covariance = []; 

for i = 1:size(training_input)
    
    %First calculate the network output for the current input in it's current state. 
    predicted_output = predict_ouput(training_input(i,:), neurons, beta, weights);
    
    %Calculate parameters needed to check if growth is needed:
    
    delta_output = training_output(i,:) - predicted_output;
    epsilon = max(epsilon_max*gamma^i, epsilon_min);
    
    %find nearest neuron to input vector 
%     D = pdist2(training_input(i,:), neurons);
%     nearest_neuron = min(D);
      k = dsearchn(neurons,training_input(i,:));
      nearest_neuron = neurons(k,:);


    %Apply criterion for adding neurons
    %Tests each input against a growing criterion
    %If criterion are met, new neuron is initialised with standard parameters
    
    if norm(training_input(i,:) - nearest_neuron) > epsilon && norm(calc_growing_criterion(delta_output,beta, training_input(i,:))) > epsilon_min
       
        %If the previous conditions are true, add a new neuron with the
        %parameters: 
        %Weight = delta_output
        %Neuron = input_vector
        
        weights = [weights;delta_output];
        neurons = [neurons;training_input(i,:)];
        activations = [activations;calc_activation(nearest_neuron,beta,training_input(i,:))];
        
    else
        %Else adjust the nearest neuron to accomodate the new input signal 
        %Using the EKF algorithim 
        %Find nearest neuron
        k = dsearchn(neurons,training_input(i,:));
        nearest_neuron = neurons(k,:);
        EKF(nearest_neuron, predicted_output,training_input(i,:) ,training_output(i,:), beta, weights(k,:))
        
        
        %Following adjustment, check the neuron to see if it satisfies
        %pruning criterion
        
        significance = Calc_Neuron_Significance(nearest_neuron,beta);
        
        if (significance < emin)
            %Prune neuron from netowork
            neurons(k,:) = [];
            weights(k,:) = [];
            activations(k,:) = [];
            %Reduce EKF dimentionality 
            EK_Error_Covariance(k,:) = [];
            
        end
        
    end
        
end



%Pruning neurons
%If the significance of a neuron is below  a threshold the neuron is
%considered insignificant and thus removed from the network. Else the
%neuron is significant and is retained.
%Theoretically significance of all neurons should be computed after each
%training example, however only the nearest neuron (in euclidean distance) is possibly made
%redudant and so that is the one that must be tested for significance. 



