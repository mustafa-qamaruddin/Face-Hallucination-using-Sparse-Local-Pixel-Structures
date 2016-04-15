function [ ret_lambda_mse, ret_lambda_psnr ] = mqReconstruct(learning_rate)
%%interpolated_image, coeffiecients_weights, k_images,%%
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%im_path = 'C:\Users\Qamar-ud-Din\Documents\MATLAB\SplitFrame_479.bmp';

%%testim = imread(im_path);
global LOW_RES_INPUT_TEST_IMAGE;
testim = LOW_RES_INPUT_TEST_IMAGE;
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
global PATCH_SIZE;
PATCH_SIZE = 7;
global SHOW_MSE_ANALYTICS;
global NUM_RECONSTRUCTION_ITERATIONS;
NUM_RECONSTRUCTION_ITERATIONS = 150;

%% scale factor $$
g = learning_rate;

%% LOAD COEFFICIENTS WEIGHTS %%
w = struct2cell(load('coefficients_omega_for_all_patches.mat'));
w = w{1};

%% PADDING $$
offset=floor(PATCH_SIZE/2);
interpolated_image = padarray(interpolated_image, [offset offset]);
padded_test_image = padarray(testim, [offset offset]);

%% LOOP T ITERATIONS %%
    %% Christina Init Arrays for Plotting %%
    mse_for_iterations = zeros(NUM_RECONSTRUCTION_ITERATIONS, 1);
    psnr_for_iterations = zeros(NUM_RECONSTRUCTION_ITERATIONS, 1);
    %% END Christina %%
    for t = 1 : NUM_RECONSTRUCTION_ITERATIONS
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
                DELTA_T = double(I0) - dot(weights, double(patch));
                if DELTA_T ~= 0
                    DELTA_T;
                end
                I = I0 - g * DELTA_T;
                I - I0;
                %%%% cutoff here
                if I < 0 
                    I = 0
                elseif I > 255
                    I = 255
                end
                interpolated_image(r,c) = I;
                counter = counter + 1;
            end
        end
        %% Christina MSE
        if(SHOW_MSE_ANALYTICS == true)
            mse_for_iterations(t,1) = immse(padded_test_image, interpolated_image);
            [peaksnr, snr] = psnr(interpolated_image, padded_test_image);
            psnr_for_iterations(t,1) = peaksnr;
        end
        %% END Christina MSE
    end
        the_title = sprintf('Hallucinated Image @iteration:=%d', NUM_RECONSTRUCTION_ITERATIONS);
        hold on
        figure, imshow(interpolated_image), title(the_title);
        hold off
        figure, imshow(testim), title('Ground Truth');
        
        %% Christina PLOT MSE
        if(SHOW_MSE_ANALYTICS == true)
            figure, plot(mse_for_iterations), title('MSE(#Iterations)'), xlabel('#Iterations'), ylabel('MSE');
            figure, plot(psnr_for_iterations), title('PSNR(#Iterations)'), xlabel('#Iterations'), ylabel('PSNR');
        end
        %% END Christina PLOT MSE
        
        %% Christina LAMBDA MSE
        ret = [0, 0];
        if(SHOW_MSE_ANALYTICS == true)
            ret_lambda_mse = immse(padded_test_image, interpolated_image);
            [peaksnr, snr] = psnr(interpolated_image, padded_test_image);
            ret_lambda_psnr = peaksnr;
        end
        %% END Christina LAMBDA MSE
end