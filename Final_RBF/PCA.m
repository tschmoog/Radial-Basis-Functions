function[reduced_dimentions] = PCA(input_data, dim_reduced) 
%PCA algorithim


%Find covariance matrix

C = cov(input_data);

%Find eigenvalues + eigenvactors

[Eigvectors, Eigvals] = eig(C);

%Sort eigen values and vectors into descending order so we can eliminate
%the components that contain least information

[Eigvectors_sorted ,Eigvals_sorted]=sortem(Eigvectors,Eigvals);


%Take the first K eigenvectors, to reduce dimentionality of original data
%to K dimentions
K = dim_reduced;

Eig_reduce = Eigvectors_sorted(:,1:K);

%Now vectors with reduced dimentionality can be produced using the reduced
%eig matrix

feature_data = zeros(length(input_data),K);

trans_input_data = input_data';

for i = 1: length(input_data)
    
    feature_data(i,:) = Eig_reduce'*trans_input_data(:,i);

end

reduced_dimentions = feature_data;

end

