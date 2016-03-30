function [ hallucinated_image ] = mqReconstruct( interpolated_image, coeffiecients_weights, k_images )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

im_path = 'C:\Users\Qamar-ud-Din\Documents\MATLAB\SplitFrame_479.bmp';

testim = imread(im_path);

%% low resolution %%
lowresim = imresize(testim, 0.125);
figure, imshow(lowresim), title('low resolution');

interpolated_image = imresize(lowresim, [128 128], 'method', 'cubic');
figure, imshow(interpolated_image), title('interpolated low resolution');

%% to be calculated from low resolution input image and target high resolution %%
global DOWNSAMPLING_FACTOR;
DOWNSAMPLING_FACTOR = 128 / 16;
global SCALEFACTOR;
SCALEFACTOR = 0.05;
global NUMBERITERATIONS;
NUMBERITERATIONS = 150;
global PATCH_SIZE;
PATCH_SIZE = 7;

%% scale factor $$
g = 0.05;

%% LOAD COEFFICIENTS WEIGHTS %%
w = struct2cell(load('coefficients_omega_for_all_patches.mat'));
w = w{1};
%% LOOP T ITERATIONS %%

        counter = 1;
        %% loop rows
        fin_col = size(interpolated_image, 2) - PATCH_SIZE + 1;
        step_col = PATCH_SIZE - 0;
        for c = 1 : step_col : fin_col
            %% loop cols
            fin_row = size(interpolated_image, 1) - PATCH_SIZE + 1;
            for r = 1 : PATCH_SIZE : fin_row
                I0 = interpolated_image(r, c);
                patch = interpolated_image([r:r+PATCH_SIZE-1], [c:c+PATCH_SIZE-1]);
                patch = mqExtractNeighborhoodFromSinglePatch(patch, PATCH_SIZE);
                weights = cell2mat(w(counter));
                DELTA_T = I0 -  dot(weights, double(patch));
                I = I0 - g * DELTA_T;
                I - I0
                interpolated_image(r,c) = I;
                counter = counter + 1;
            end
        end

    figure, imshow(interpolated_image), title('Hallucinated Image');

        
end

