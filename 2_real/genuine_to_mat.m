num_images = 27;
num_train = 22;
num_test = num_images - num_train;

image_rows = 69;
image_cols = 117;

genuine_train = zeros(image_rows, image_cols, num_train);
genuine_test = zeros(image_rows, image_cols, num_test);

for k = 1 : num_train
    tifFileName = strcat('processed', num2str(k), '.tif');
    if isfile(tifFileName)
        image = imread(tifFileName);
        genuine_train(:,:,k) = rgb2gray(image);
    else
        fprintf('File %s does not exist.\n', tifFileName);
    end
end;

for i = (num_train+1): num_images
    tifFileName = strcat('processed', num2str(i), '.tif');
    if isfile(tifFileName)
        image = imread(tifFileName);
        genuine_test(:,:,(num_images - i + 1)) = rgb2gray(image);
    else
        fprintf('File %s does not exist.\n', tifFileName);
    end
end;

save genuine.mat genuine_train genuine_test


