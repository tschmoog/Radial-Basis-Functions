function [ centres ] = calculate_centres( training_input, prev_clus_points, index, k )
%Function calculates the new centres of the network

%Take size of training input
[m,n] = size(training_input);

centres = zeros(k,n);

%For each centre

for i = 1:k
    
    %If there are no points assigned to centre dont change its location
    if (~any(index == i))
        centres(i, :) = prev_clus_points(i, :);
        
    else
        %Otherwise find a new centre
        %Get points in centre i
        points = training_input((index == i),:);
        
        %calculate new centre
        centres(i,:) = mean(points);
    end
        

    
end


end

