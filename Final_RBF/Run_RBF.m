function [ predicted_output ] = Run_RBF(input_data, centre_locations, betas, weights)

%Run the now trained RBF

%Returns: 1 x n vector of predicted output values

predicted_output = zeros(size(input_data,1),1); 

for i = 1: size(input_data,1)
    
    activation = calc_activation(centre_locations, betas, input_data(i,:));
    %Add bias term
    activation = [1;activation];
    %Activations * weights and take sum
    predicted_output(i,1) = weights'*activation;
    
end


end

