function [ index, clus_points ] = KMeansClus( K, training_input, iterations )
%K Means clustering algorithim 
% In this method, the squared Euclidean norm is used to define similarity between
% vectors
% Parameters:
%K: The number of desired clusters
%Iterations : Max number of iterations if centres do not converge
%training_input: The input data  

size_input = size(training_input,1);

%Create matrix to hold which points are assigned where
clus_points = zeros(K, size(training_input, 2));
%Generate random numbers to select inital centres and take first K for
%centres
rand_selection = randperm(size_input);
clus_points = training_input(rand_selection(1:K),:);

%Create a copy of points to see when clusters converge
prev_points = clus_points;

%__________________________________________
%K means
%__________________________________________

for i = 1:iterations
    
    %Assign each feature vector to its nearest centre
    index = find_nearby_centre(training_input,clus_points);
    
    %Given the now assigned vectors, recalculate the centres 
    clus_points = calculate_centres(training_input, clus_points, index, K);
    
    %Check to see if centres have converged. If yes then end loop else
    %continue
    
    if (prev_points == clus_points)
        break;
    end
    
    prev_points = clus_points;

end
    
    

end

