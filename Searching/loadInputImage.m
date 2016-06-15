function [] = loadInputImage()
global LOW_RES_INPUT_TEST_IMAGE;
[file, path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.gif';}, 'Select Low Resolution Input Image');
LOW_RES_INPUT_TEST_IMAGE = imread(strcat(path, file));
imshow(LOW_RES_INPUT_TEST_IMAGE);
end