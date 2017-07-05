function [ E ] = LeastSquaredError( predicted_output, correct_values)
%Least squared error function, returns error of values

holder = zeros(size(predicted_output,1),1);

for i = 1:size(predicted_output)
    X = predicted_output(i,1) - correct_values(i,1);
    X2 = X^2;
    holder(i,1) = X2;


end

X3 = sum(holder);

E = X3/2;

end