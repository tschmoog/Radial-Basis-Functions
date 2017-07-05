function [ RMSE ] = RMSError( predicted_output, true_output )
%Calcualates the root mean squared error of the funciton.
%RMSE amplifies and severely punishes large errors
RMSE = sqrt(mean((true_output - predicted_output).^2));


end

