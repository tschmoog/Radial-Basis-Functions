function [ x ] = calc_growing_criterion(delta_output, beta, input_vector)
%Calculates the growing criterion for adding a neuron, if the returned
%value is greater than emin then a new neuron is needed to represent input
%data.

%This function us the same as calculating the statistical significance of a neuron except
%That the difference between predicted and desired output in euclidean
%distance is used instead of the weight value. 

mu = 0;
q = 10;



%The q-norm of the weight vector. In this case q = 10
w = norm(delta_output,q);
%Second term in the equation
t2 = nthroot((beta)/(sqrt(2*q*beta)),q);
%3rd term
t3 = exp(-(mu - input_vector).^2/(2*q*beta^2));

x = w*t2*t3;



end

