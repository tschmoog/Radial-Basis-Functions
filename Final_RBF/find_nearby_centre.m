function [index] = find_nearby_centre(training_examples,centres)
%Function takes in all the training data and calculates the nearest centre
%for each feature vector.  

%Number of centres
num_centres = size(centres,1);

%Number of feature vectors
num_input_vectors = size(training_examples,1);

%Initialise matrix to hold which vectors are assigned to which centre
centre_assign = zeros(num_input_vectors,1);

%Initialise matrix to hold distance between feature vectos and cluster
distances = zeros(num_input_vectors, num_centres);

%For each cluster, find distance to each vector

for i = 1: num_centres
    
    dist = bsxfun(@minus,training_examples, centres(i,:));
    
    %Square diff for absloute dist
    sqdist = dist.^2;
    
    %Sum sqdist
    
    distances(:,i) = sum(sqdist,2);
    
end

%Take minimum distance and set index
[min_dist, index] = min(distances, [],2);

end

