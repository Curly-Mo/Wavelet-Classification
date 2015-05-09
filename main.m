function main(train_dir, test_dir, model_file)
    tic;

    % Default values for optional parameters
    if ~exist('train_dir', 'var')
       train_dir = 'data/train';
    end
    if ~exist('test_dir', 'var')
       test_dir = 'data/test';
    end
    if exist(model_file, 'file')
       model = load(model_file);
       disp(model);
    end
    
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
    
    % Get cell-array of train and test files/labels
    disp('Loading files...');
    [train_files, train_labels] = get_files(train_dir);
    [test_files, test_labels] = get_files(test_dir);
    
    % Compute Features
    if ~isfield(model, {'train_features', 'train_labels', 'a', 'b'})
        toc;
        disp('Computing train features...');
        [train_features, train_labels, a, b] = create_train_set(train_files, train_labels, params);
        model.train_features = train_features;
        model.train_labels = train_labels;
        model.a = a;
        model.b = b;
        if ~exist(model_file, 'var')
            save(model_file, '-struct', 'model');
        end
    end
    toc;
    disp('Computing test features...');
    [test_features, test_labels] = create_test_set(test_files, test_labels, params, model.a, model.b);
    
    % Predict class
    toc;
    disp('Predicting labels...');
    predicted_labels = predict_labels(model.train_features, model.train_labels, test_features, 15);
    [overall_accuracy, per_class_accuracy] = score_prediction(test_labels, predicted_labels, true);
    
    disp(['Overall Accuracy: ', num2str(overall_accuracy)]);
    disp(['Per Class Accuracy: ', num2str(per_class_accuracy)]);
    disp(char(10));
    
    if ~exist('output', 'dir')
       mkdir('output');
    end 
    print(gcf, '-r600', ['output/', datestr(clock, 0)], '-dpng');
    
    disp('Done');
    toc;
end