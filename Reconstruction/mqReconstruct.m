function [ ret_lambda_mse, ret_lambda_psnr, ret_lambda_ssim ] = mqReconstruct(learning_rate)
%%interpolated_image, coeffiecients_weights, k_images,%%
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%im_path = 'C:\Users\Qamar-ud-Din\Documents\MATLAB\SplitFrame_479.bmp';

%%testim = imread(im_path);
global LOW_RES_INPUT_TEST_IMAGE;
global HIGH_RES_INPUT_TEST_IMAGE;
testim = HIGH_RES_INPUT_TEST_IMAGE;
%% low resolution %%
figure(2), imshow(testim), title('Low Resolution');

interpolated_image = imresize(testim, [32 32], 'method', 'cubic');
figure(3), imshow(interpolated_image), title('Interpolated Low Resolution');

%% to be calculated from low resolution input image and target high resolution %%
global DOWNSAMPLING_FACTOR;
DOWNSAMPLING_FACTOR = 32 / 16;
global SCALEFACTOR;
SCALEFACTOR = 0.05;
global PATCH_SIZE;
PATCH_SIZE = 7;
global SHOW_MSE_ANALYTICS;
global NUM_RECONSTRUCTION_ITERATIONS;
NUM_RECONSTRUCTION_ITERATIONS = 10;

%% scale factor $$
g = learning_rate;

%% LOAD COEFFICIENTS WEIGHTS %%
w = struct2array(load('coefficients_omega_for_all_patches.mat'));
total_num_patches = size(w, 1);

%% PADDING $$
offset=floor(PATCH_SIZE/2);
interpolated_image = padarray(interpolated_image, [offset offset]);
padded_test_image = padarray(testim, [offset offset]);

%% LOOP T ITERATIONS %%
    %% Init Arrays for Plotting %%
    mse_for_iterations = zeros(NUM_RECONSTRUCTION_ITERATIONS, 1);
    psnr_for_iterations = zeros(NUM_RECONSTRUCTION_ITERATIONS, 1);
    ssim_for_iterations = zeros(NUM_RECONSTRUCTION_ITERATIONS, 1);
    %% END %%
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
                if counter <= total_num_patches
                    weights = w{counter};
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
                end
                counter = counter + 1;
            end
        end
        %% MSE
        if(SHOW_MSE_ANALYTICS == true)
            mse_for_iterations(t,1) = immse(padded_test_image, interpolated_image);
            [peaksnr, snr] = psnr(interpolated_image, padded_test_image);
            psnr_for_iterations(t,1) = peaksnr;
            %%[ssimval, ssimmap] = ssim(interpolated_image, padded_test_image);
            %%ssim_for_iterations(t,1) = ssimval;
        end
        %% END MSE
    end
        the_title = sprintf('Hallucinated Image @iteration:=%d', NUM_RECONSTRUCTION_ITERATIONS);
        hold on
        figure, imshow(interpolated_image), title(the_title);
        hold off
        figure, imshow(testim), title('Ground Truth');
        
        %% PLOT MSE
        if(SHOW_MSE_ANALYTICS == true)
            figure, plot(mse_for_iterations), title('MSE(#Iterations)'), xlabel('#Iterations'), ylabel('MSE');
            figure, plot(psnr_for_iterations), title('PSNR(#Iterations)'), xlabel('#Iterations'), ylabel('PSNR');
            figure, plot(ssim_for_iterations), title('SSIM(#Iterations)'), xlabel('#Iterations'), ylabel('SSIM');
        end
        %% END PLOT MSE
        
        %% LAMBDA MSE
        ret = [0, 0];
        if(SHOW_MSE_ANALYTICS == true)
            %% MSE
            ret_lambda_mse = immse(padded_test_image, interpolated_image);
            %% PSNR
            [peaksnr, snr] = psnr(interpolated_image, padded_test_image);
            ret_lambda_psnr = peaksnr;
            %% SSIM
            %%[ssimval, ssimmap] = ssim(interpolated_image, padded_test_image);
            %%ret_lambda_psnr = ssimval;
        end
        %% END LAMBDA MSE
end