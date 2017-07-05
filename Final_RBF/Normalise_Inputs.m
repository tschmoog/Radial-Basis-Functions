function [ training_input, testing_input ] = Normalise_Inputs(training_input_original , testing_input_original )
%This function normalises the input data

%Preallocate memory 
training_input = zeros(length(training_input_original(:,1)), length(training_input_original(1,:)));
testing_input = zeros(length(testing_input_original(:,1)), length(testing_input_original(1,:)));

%Normalise testing and training
for i = 1: size(training_input,2)
    
    training_input(:,i) = Gauss_Norm(training_input_original(:,i));


end

%2 For loops as testing/train are different sizes. 
for i = 1:size(testing_input,2)

    testing_input(:,i) = Gauss_Norm(testing_input_original(:,i));

end

end

