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

%% PADDING $$
offset=floor(PATCH_SIZE/2);
interpolated_image = padarray(interpolated_image, [offset offset]);
        
%% LOOP T ITERATIONS %%
    for t = 1 : 150
        counter = 1;
        %% loop rows
        fin_row = size(interpolated_image, 2) - offset;
        for c = offset+1 : fin_row
            %% loop cols
            fin_col = size(interpolated_image, 1) - offset;
            for r = offset+1 : fin_col
                I0 = interpolated_image(r, c);
                patch = interpolated_image([r-offset:r+offset], [c-offset:c+offset]);
                patch = mqExtractNeighborhoodFromSinglePatch(patch, PATCH_SIZE);
                weights = cell2mat(w(counter));
                DELTA_T = I0 -  dot(weights, double(patch));
                I = I0 - g * DELTA_T;
                I - I0
                interpolated_image(r,c) = I;
                counter = counter + 1;
            end
        end
        the_title = sprintf('Hallucinated Image @iteration:=%d', t);
        hold on
        figure, imshow(interpolated_image), title(the_title);
        hold off
    end
    figure, imshow(testim), title('Ground Truth');
end

