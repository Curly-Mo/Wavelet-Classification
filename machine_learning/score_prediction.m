function [overall_accuracy, per_class_accuracy] = ...
score_prediction(test_labels, predicted_labels, plot)
% Compute the confusion matrix given the test labels and predicted labels.
%
% Colin Fahy
% cpf247@nyu.edu
%
% Parameters
% ----------
% test labels: 1 x NE array
% array of ground truth labels for test data
% predicted labels: 1 x NE test array
% array of predicted labels
% plot: boolean
% Optional parameter to plot confusion matrix
%
% Returns
% -------
% overall accuracy: scalar
% The fraction of correctly classified examples.
% per class accuracy: 1 x 4 array
% The fraction of correctly classified examples
% for each instrument class.
% per class accuracy[1] should give the value for
% instrument class 1, per class accuracy[2] for
% instrument class 2, etc.

    [confusion, order] = confusionmat(test_labels, predicted_labels);
    
    [T, P] = size(confusion);
        
    % Sum of diagonal elements
    correct = trace(confusion);
    total = sum(sum(confusion));
    overall_accuracy= correct/total;
    
    per_class_accuracy = zeros(1, P);
    for i = 1:P
        class_correct = sum(confusion(i,i));
        class_total = sum(confusion(i,:));
        per_class_accuracy(i) = class_correct/class_total;
    end
    
    % Create percentage confusion matrix
    percent_confusion = zeros(size(confusion));
    for i = 1:T
        class_total = sum(confusion(i,:));
        percent_confusion(i,:) = confusion(i,:)/class_total;
    end
    
    % Plot the confusion matrix
    disp(confusion);
    %disp(percent_confusion);
    if (exist('plot', 'var') && plot==true)
        str_confusion = [num2str(confusion(:)),...
                         repmat(10, T*P, 1),...% Newline
                         num2str(percent_confusion(:)*100, '%0.2f'),...
                         repmat('%', T*P, 1)];
        imagesc(confusion);
        colormap(flipud(gray));
        [x,y] = meshgrid(1:P);
        hStrings = text(x(:),y(:),str_confusion, 'HorizontalAlignment','center');
        midValue = mean(get(gca,'CLim'));
        textColors = repmat(confusion(:) > midValue,1,3);
        set(hStrings,{'Color'},num2cell(textColors,2));
        set(gca,...
            'XTick',1:P,...
            'XTickLabel',order,...
            'YTick',1:P,...
            'YTickLabel',order,...
            'TickLength',[0 0]);
    end
end