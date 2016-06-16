function [] = mqPCA()
    global LOW_RES_INPUT_TEST_IMAGE;
    global VISUALS;
    global NUMBER_NEAREST_NEIGHBORS;
    
    dbl_lowres = double(LOW_RES_INPUT_TEST_IMAGE);
    width = size(LOW_RES_INPUT_TEST_IMAGE,1);
    height = size(LOW_RES_INPUT_TEST_IMAGE,2);

    rshp_lowres = reshape(LOW_RES_INPUT_TEST_IMAGE, width*height, 3);

    %% figure, imshow(rshp_lowres);
    coeff = pca(double(rshp_lowres));

    %%####################################################
    lowres_dir_path = uigetdir;
    %addpath(lowres_dir_path);
    image_files = dir(strcat(lowres_dir_path, '\*.bmp'));
    num_files = length(image_files);
    table_of_features = zeros(num_files, width*height*3, 1);
    table_of_names = cell(num_files, 1);
    table_of_names_index = zeros(num_files, 1);
    for i = 1 : num_files
        %% check isDir
        file_name = image_files(i).name;
        full_image_path = strcat(lowres_dir_path ,'\', file_name);
        original_training_image = imread(full_image_path);
        training_image = double(original_training_image);
        training_width = size(training_image, 1);
        training_height = size(training_image, 2);
        reshaped_training_image = reshape(training_image, training_width * training_height, 3);
        reduced_image = reshaped_training_image * coeff;
        if(VISUALS == true)
            image_to_be_displayed = reshape(reduced_image, training_width, training_height, 3);
            figure(1), imshow(original_training_image), title('Low Res Training');
            figure(2), imshow(image_to_be_displayed), title('PCA');
            pause
        end
        table_of_names{i, 1} = full_image_path;
        table_of_features(i, :) = reshape(reduced_image, training_width*training_height*3, 1);
        table_of_names_index(i, 1) = i;
    end
    NUMBER_NEAREST_NEIGHBORS = input('Number of Nearest Neighbors for KNN');
    sample = reshape(rshp_lowres, width*height*3, 1);
    sample_t = transpose(sample);
    cls = knnclassify(sample_t, table_of_features, table_of_names, NUMBER_NEAREST_NEIGHBORS);
    cls
    save 'table_of_features.mat' table_of_features;
    save 'table_of_names.mat' table_of_names;
end