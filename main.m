function main()
% Print the Overall Accuracy and per-class accuracy

    % Add required paths
    addpath(genpath('feature_extraction/mfcc'));
    addpath(genpath('machine_learning'));
    addpath(genpath('tools'));

    % Set parameters
    params.win_size = 1024;
    params.hop_size = 512;
    params.min_freq = 86;
    params.max_freq = 8000;
    params.num_mel_filts = 40;
    params.n_dct = 15;
    
    % Get cell-array of trian and test files
    train_dir = 'data/train';
    test_dir = 'data/test';
    train_files = dir(fullfile(train_dir, '*.wav'));
    train_filenames = fullfile(train_dir, {train_files.name});
    test_files = dir(fullfile(test_dir, '*.wav'));
    test_filenames = fullfile(test_dir, {test_files.name});
    
    % Compute Features
    [train_features, train_labels, a, b] = create_train_set(train_filenames, params);
    [test_features, test_labels] = create_test_set(test_filenames, params, a, b);
    
    % Predict class
    predicted_labels = predict_labels(train_features, train_labels, test_features, 15);
    [overall_accuracy, per_class_accuracy] = score_prediction(test_labels, predicted_labels, true);
    
    disp(['Files: ', test_filenames{:}]);
    disp(['Overall Accuracy: ', num2str(overall_accuracy)]);
    disp(['Per Class Accuracy: ', num2str(per_class_accuracy)]);
    disp(char(10));
    %print(gcf, '-r600', 'plots/k_nearest_neighbor_synth', '-dpng');
end