function [ output_args ] = Gauss_Norm( input_vector )
%Standard score normalisation
%The function takes a vector as input and returns a new normalised gaussian
%vector as output.

%Create new vector the same size as input vector
 holder = zeros([1,size(input_vector)]);

%Gaus norm = (Xcurrent - mean)/SD

%Mean of vector elements
m = mean(input_vector);

%SD of vector elements
std_dev = std(input_vector);

%Transpose holder vector 
holder = holder';

for i = 1:size(input_vector);
    holder(i,1) = (input_vector(i,1) - m)/std_dev;
end

output_args = holder;
end

