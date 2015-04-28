function [test_features, test_labels] = create_test_set(file_paths, params, a, b)
% Compute features and parameters for test data.
%
% Parameters
% ----------
% file_paths: cell-array
% list of full paths to audio files with test data
% params: struct
% struct storing the parameters
% needed for computation of MFCCs.
% The fields of the struct are: win size, hop size,
% min freq, max freq, num mel filts, n dct
% a: float
% normalization parameter
% b: float
% normalization parameter
%
% Returns
% -------
% test features: NF x NE matrix
% matrix of test set features (NF is number of
% features and NT is number of feature instances)
% test labels: 1 x NE array
% vector of labels (class numbers) for each instance
% of test features

    test_labels = [];
    test_features = [];
    
    for i = 1:length(file_paths)
        [mfccs, fs_mfcc] = compute_mfccs(char(file_paths(i)), ...
                                         params.win_size, ...
                                         params.hop_size, ...
                                         params.min_freq, ...
                                         params.max_freq, ...
                                         params.num_mel_filts, ...
                                         params.n_dct);
        features = compute_features(mfccs, fs_mfcc);
        
        test_features = [test_features, features];
        test_labels = [test_labels, ones(1,size(features,2)) * i];
    end
    
    % Normalize
    [test_features, ~, ~] = normalize_features(test_features, a, b);

end