function predicted_labels = predict_labels(train_features, train_labels, test_features, k)
% Predict the labels of the test features,
% given training features and labels,
% using a k-nearest-neighbor classifier.
%
% Colin Fahy
% cpf247@nyu.edu
%
% Parameters
% ----------
% train features: NF x NE train matrix
% matrix of training set features (NF is number of
% features and NE train is number of feature instances)
% train labels: 1 x NE train array
% vector of labels (class numbers) for each instance
% of train features
% test features: NF x NE test matrix
% matrix of test set features (NF is number of
% features and NE test is number of feature instances)
% k: integer
% Optional number of nearest neighbors to use
%
% Returns
% -------
% predicted labels: 1 x NE test array
% array of predicted labels

    if (~exist('k', 'var'))
        k = 1;
    end
    
    [F, M] = size(test_features);
    predicted_labels = zeros(1, M);
    
    for m = 1:M
        dot_product = train_features' * test_features(:, m);
        
        % K-Nearest Neighbor
        [~, sorted_indices] = sort(dot_product,'descend');
        sorted_indices = sorted_indices(1:k);
        label = mode(train_labels(sorted_indices));
        
        % Nearest Neighbor
%         [~, index] = max(dot_product);
%         label = train_labels(index);
        
        predicted_labels(m) = label;
    end
    
end