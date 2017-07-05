function [ significance ] = Calc_Neuron_Significance(neuron, beta)
%This function calculates the statistical significance of a neuron. 

mu = 0;
q = 10;


%The q-norm of the weight vector. In this case q = 10
w = norm(weight,q);
%Second term in the significance equation
t2 = nthroot((beta)/(sqrt(2*q*beta)),q);
%3rd term
t3 = exp(-(mu - neuron)^2/(2*q*beta^2));

significance = w*t2*t3;


end

