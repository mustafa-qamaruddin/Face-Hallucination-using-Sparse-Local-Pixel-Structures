function [] = loadInputImage()
global LOW_RES_INPUT_TEST_IMAGE;
global HIGH_RES_INPUT_TEST_IMAGE;

%% Low-Res
[file, path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.gif';}, 'Select Low Resolution Input Image');
LOW_RES_INPUT_TEST_IMAGE = imread(strcat(path, file));

%% High-Res
[file, path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.gif';}, 'Select High Resolution Input Image');
HIGH_RES_INPUT_TEST_IMAGE = imread(strcat(path, file));

figure(1), imshow(LOW_RES_INPUT_TEST_IMAGE), title('Low Res Input');

end