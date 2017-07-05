%This script takes in the test file and produces a list of predicted
%outputs, the RMS Error and a plot showing the predicted against actual outputs.  

%Read testfile
datafile = csvread('testdata.csv');
load('betas.mat');
load('centres.mat');
load('weights.mat');

%Take important features from datafile
input_vectors = datafile(:,[1 6 10]);

%Normalise inputs 
[input_vectors, input_vectors] = Normalise_Inputs(input_vectors, input_vectors);

%produce predictions
predicted_outputs = Run_RBF(input_vectors, centres, betas, weights);

Error = RMSError(predicted_outputs, datafile(:,11));

figure
hold on
plot(predicted_outputs)
plot(datafile(:,11))