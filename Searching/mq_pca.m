im_path = '\\Vboxsvr\root\media\qamar-ud-din\709E751C9E74DBD2\FaceHallucination_released\AlignedSet\SplitFrame_000.bmp';
lowres = imread(im_path);
dbl_lowres = double(lowres);
width = size(lowres,1);
height = size(lowres,2);

rshp_lowres = reshape(lowres, width*height, 3);

%% figure, imshow(rshp_lowres);
coeff = pca(double(rshp_lowres));

%%####################################################

%% lowres_dir_path = '\\Vboxsvr\root\media\qamar-ud-din\709E751C9E74DBD2\FaceHallucination_released\AlignedSet\';
lowres_dir_path = uigetdir;
%addpath(lowres_dir_path);
image_files = dir(strcat(lowres_dir_path, '\*.bmp'));
num_files = length(image_files);
table_of_features = [];
for i = 1 : num_files
    %% check isDir
    file_name = image_files(i).name;
    training_image = imread(strcat(lowres_dir_path ,'\', file_name));
    training_image = double(training_image);
    training_width = size(training_image, 1);
    training_height = size(training_image, 2);
    reshaped_training_image = reshape(training_image, width * height, 3);
    reduced_image = reshaped_training_image * coeff;
    table_of_features = [table_of_features; transpose(reduced_image)];
end
save features.dat table_of_features -ascii -double;