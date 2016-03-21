function [ output_args ] = mq_optical_test( input_args )
%MQ_TES Summary of this function goes here
%   Detailed explanation goes here

%% ## BEGIN READ INTERPOLATED LOW RES IMAGE ##
im_path = 'C:\Users\Qamar-ud-Din\Documents\MATLAB\SplitFrame_462.bmp';

lowres = imread(im_path);

figure, imshow(lowres), title('INTERPOLATED LOW RES INPUT IMAGE');
%% ## END READ INTERPOLATED LOW RES IMAGE ##

%% ## BEGIN READ K NEAREST HIGH RES IMAGE ##

%% IMAGE FILE IO
lowres_dir_path = uigetdir;
image_files = dir(strcat(lowres_dir_path, '\*.bmp'));
num_files = length(image_files);

%% LOOP K IMAGES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
training_images = cell(num_files);
for i = 1 : num_files
    file_name = image_files(i).name;
    training_image = imread(strcat(lowres_dir_path ,'\', file_name));
    training_images{i} = [training_image];
end

mq_buildOverCompleteDictionary(training_images, num_files);
    
    file_name = sprintf('warping/warping_error__%d.txt', i);
    dlmwrite(file_name, warping_error);
    type(file_name);
    

%% ## END READ K NEAREST HIGH RES IMAGE ##
dlmwrite('warping_errors.dat', table_of_warping_errors, 'newline','pc');

end