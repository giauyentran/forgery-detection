num_images = 36;
num_train = 31;
num_test = num_images - num_train;

image_rows = 182;
image_cols = 312;

forgery_train = zeros(image_rows, image_cols, num_train);
forgery_test = zeros(image_rows, image_cols, num_test);

for k = 1 : num_train
    tifFileName = strcat('processed', num2str(k), '.tif');
    if isfile(tifFileName)
        image = imread(tifFileName);
        forgery_train(:,:,k) = rgb2gray(image);
    else
        fprintf('File %s does not exist.\n', jpgFileName);
    end
end;

for i = (num_train+1): num_images
    tifFileName = strcat('processed', num2str(i), '.tif');
    if isfile(tifFileName)
        image = imread(tifFileName);
        forgery_test(:,:,(num_images - i + 1)) = rgb2gray(image);
    else
        fprintf('File %s does not exist.\n', jpgFileName);
    end
end;

save forgery.mat forgery_train forgery_test

