function [f1] = EKF(neuron, predicted_output,training_input, training_output, beta, weight)
%The Extended Kalman Filter algorithim adjusts an existing neurons parameters to better
%represent the data given a novel input. 
%Prediction equations 

%y_est = Estimated output 
y_est = predicted_output; 
%P = Estimated state covariance
P = P;

%X,x is current state and what is being updated, in this case my neurons position, and weight.
%These are initialised to their current values.
x = [neuron];

%Input = current centre, current weight, input vector
%u = vector of inputs 
u = training_input;
%y = actual process output
y = training_output;
%w = weights
w = weight;
%b = beta
b = beta;
%Omit noise for simplicity 

syms aa bb cc dd 

%Work out jacobians of our predictor functions
F = jacobian([predict_ouput(aa,bb,cc,dd)] , [aa,bb,cc,dd]);
%F = jacobian([predict_ouput(u,x,b,w)] , [u,x,b,w]);



H = jacobian([predict_ouput(u,u,b,w)], [u,x,b,w]);
h1 = predict_output(u,u,b,w);

%Predictor step
f1 = predict_ouput(u,x,b,w);
P = F*P*F';

%Corrector step:
%Kalman gain:
K = (P*H')/(H*P*H');
f1 = f1 + K(y - predict_ouput(f1,x,b,w)); %%%%%%
I = K*K'; %Identity matrix
P = (I - K*H)*P;
end

