function [ output_args ] = mq_optical_test( k_images )
%MQ_TES Summary of this function goes here
%   Detailed explanation goes here
global LOW_RES_INPUT_TEST_IMAGE;
lowres = LOW_RES_INPUT_TEST_IMAGE;
global OPTICAL_FLOW_ALGORITHM;
%% ## BEGIN READ INTERPOLATED LOW RES IMAGE ##

%%##figure, imshow(lowres), title('INTERPOLATED LOW RES INPUT IMAGE');
%% ## END READ INTERPOLATED LOW RES IMAGE ##

%% ## BEGIN READ K NEAREST HIGH RES IMAGE ##

%% IMAGE FILE IO
%lowres_dir_path = uigetdir;
%image_files = dir(strcat(lowres_dir_path, '\*.bmp'));

num_files = size(k_images, 1);

%% LOOP K IMAGES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
cell_warping_errors = cell(num_files, 1);
for i = 1 : num_files
    %%##file_name = image_files(i).name;
    %%##training_image = imread(strcat(lowres_dir_path ,'\', file_name));
    training_image = k_images{i};
    
    if OPTICAL_FLOW_ALGORITHM == 0
        warping_error = mq_opticalflow(lowres, training_image);
    else
        warping_error = k_opticalflow(lowres, training_image);
    end
    
    %%##file_name = sprintf('warping/warping_error__%d.txt', i);
    %%##dlmwrite(file_name, warping_error);
    %%##type(file_name);
    
    cell_warping_errors{i} = warping_error;
end

%% ## END READ K NEAREST HIGH RES IMAGE ##
%%##dlmwrite('warping_errors.dat', table_of_warping_errors, 'newline','pc');
output_args = cell_warping_errors;
end







