load ./2_real/genuine.mat
load ./2_forgery/forgery.mat
verbose = false;

%     assigning data
    trainer = cat(3, genuine_train, forgery_train);
    test = cat(3, genuine_test, forgery_test);
    
    % showing first 25 raw images
    if verbose
        figure;
        sgtitle("Raw Images")
        for i=1:25
            subplot(5, 5, i);
            imagesc(trainer(:, :, i))
            colormap('gray')
        end
    end
    
    % reshaping
    trainer = reshape(trainer, 69*117, 53)';
    test = reshape(test, 69*117, 10)';
    
    % mean center
    trainer = trainer - mean(trainer);
    test = test - mean(test);
    
    % covariance matrix
    covar = (1/8072) * (trainer' * trainer);
    
    % eigenthings
    [vectors, ~] = eigs(covar, 12);
    
    % showing eigenfaces 
    if verbose
        figure;
        for i = 1:12       
            subplot(3, 4, i);
            imagesc(reshape(vectors(:,i), [69 117]));
            colormap('gray')
        end
        sgtitle('Eigensigs')
    end
        
    % projecting training data
    projectedTrain = vectors' * trainer';
    projectedTest = vectors' * test';

    mean_genuine = mean(projectedTrain(:,1:22), 2);
    mean_forgery = mean(projectedTrain(:,23:53), 2);
    status_train = [0 0 0 0 0 1 1 1 1 1];

    
    % prediction + accuracy checking
    tracker = NaN(1,10);

%     plotting
    clf; hold on; grid on;
    plot(projectedTrain(1, 1:22), projectedTrain(2, 1:22), 'ro')
    plot(projectedTrain(1, 23:53), projectedTrain(2, 23:53), 'go')
    plot(projectedTest(1, 1:5), projectedTest(2, 1:5), 'bx')
    plot(projectedTest(1, 6:10), projectedTest(2, 6:10), 'cx')
    plot(mean_genuine(1), mean_genuine(2), 'r*', 'MarkerSize',12)
    plot(mean_forgery(1), mean_forgery(2), 'g*', 'MarkerSize',12)
    legend('Genuine training signatures', 'Forged training signatures', 'Genuine test signatures','Forged test signatures', 'Mean of genuine training signatures', 'Mean of forged training signatures')
    
    for test_index = 1:10
        distance_genuine = sqrt(sum((projectedTest(:, test_index)-mean_genuine).^2));
        distance_forgery = sqrt(sum((projectedTest(:, test_index)-mean_forgery).^2));
        tracker(test_index) = (distance_genuine > distance_forgery) == status_train(test_index);
    end
    accuracy = mean(tracker)