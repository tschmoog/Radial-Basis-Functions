function [ ER, EL ] = Calculate_Errors(predicted_output, true_output)
%Function returns the error of the trained RBF
ER = RMSError(predicted_output, true_output);
EL = LeastSquaredError( predicted_output, true_output);

R = 'Root mean squared error';
L = 'Least squared error';

E1 = sprintf('%s is: %d', R, ER)
E2 = sprintf('%s is: %d', L, EL)
end

