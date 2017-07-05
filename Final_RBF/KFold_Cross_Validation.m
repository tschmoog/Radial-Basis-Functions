                           % Data
%Dataset is read from file, preprocessed and split into training and
%testing sets which can easily be used for K-fold cross validation
%The sets are then used to train and assess the RBF and the results are
%shown 

%WARNING: This trains the RBF 5 times. Due to my own K-means implementation
%this can be slow used with over 1500 centres. 

datafile = csvread('mydata.csv');

%Initialise matrix to hold error
Errors = [0,0,0,0,0];

%Randomise the data for easy K-Fold validation:

%1 Randomly order the inputs:
%create index vector
shuffle = randperm(10000)';
%Rearrange dataset into order indicated by vector
shuffled_data = datafile(shuffle,:);


%Split the input matrix and outut values
testdata = shuffled_data(:,[1 6 10]); % [1 6 10]
Output = shuffled_data(:,11);

%Optional: Split data smaller for faster testing
% testdata = testdata(1:2000,:);
% Output = Output(1:2000,:);

%Use circshift to rotate the data 
%5 fold cross validation

for i = 1:5
    
    %Use circshift to rotate the data 
    testdata = circshift(testdata,2000);
    Output = circshift(Output,2000);
    
    %Split data into training and testing:
    %Training data:
    training_input_original = testdata(1:8000,:); 
    training_output = Output(1:8000,:); 
    
    %Testing data:
    testing_input_original = testdata(8000:10000,:);
    testing_output = Output(8000:10000,:);
    
    %Normalise data, 
    [training_input, testing_input] = Normalise_Inputs(training_input_original, testing_input_original);
    
    %Apply PCA, dim_reduce = number of dimentions to be reduced to
%     dim_reduce = 9;
%     training_input = PCA(training_input, dim_reduce);
%     testing_input = PCA(testing_input, dim_reduce); 
    
    %Train RBF
    [betas, centres, weights] = Train_RBF(0.61, 550, training_input, training_output);
    
    %Test RBF
    predicted_output = Run_RBF(testing_input, centres, betas, weights);
    
    %Evaluate RBF
    Errors(1,i) = RMSError(predicted_output, testing_output);

end

%Return final average error over k folds
mean(Errors) 

figure
scatter(predicted_output,testing_output)
title 'Scatter'

LeastSquaredError(predicted_output, testing_output)

figure
hold on
plot(predicted_output)
plot(testing_output)

title 'Testing'

