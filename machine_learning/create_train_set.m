function [train_features, train_labels, a, b] = create_train_set(file_paths, params)
% Compute features and parameters for traiv
%
% Parameters
% ----------
% file_paths: cell-array
% list of full paths to audio files with train data
% params: struct
% Matlab structure with fields are win size, hop size,
% min freq, max freq, num mel filts, n dct, the parameters
% needed for computation of MFCCs
%
% Returns
% -------
% train features: NF x NE matrix
% matrix of training set features (NF is number of
% features and NT is number of feature instances)
% train labels: 1 x NE array
% vector of labels (class numbers) for each instance
% of train features

    train_labels = [];
    train_features = [];
    
    for i = 1:length(file_paths)
        [mfccs, fs_mfcc] = compute_mfccs(char(file_paths(i)), ...
                                         params.win_size, ...
                                         params.hop_size, ...
                                         params.min_freq, ...
                                         params.max_freq, ...
                                         params.num_mel_filts, ...
                                         params.n_dct);
        features = compute_features(mfccs, fs_mfcc);
        
        train_features = [train_features, features];
        train_labels = [train_labels, ones(1,size(features,2)) * i];
    end
    
    % Normalize all features together
    [train_features, a, b] = normalize_features(train_features);
end