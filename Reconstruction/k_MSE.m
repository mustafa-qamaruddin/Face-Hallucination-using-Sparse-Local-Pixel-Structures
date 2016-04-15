function [ output_args ] = k_MSE( input_args )
global SHOW_MSE_ANALYTICS;

    %% Christina Lambda Iterations %%
    mse = zeros(10, 1);
    psnr = zeros(10, 1);
    lambdas = zeros(10, 1);
    counter = 1;
    for lambda = 0.01:0.1:1
        [mse_for_lambda_iterations, psnr_for_lambda_iterations] = mqReconstruct(lambda);
        lambdas(counter, 1) = lambda;
        mse(counter, 1) = mse_for_lambda_iterations;
        psnr(counter, 1) = psnr_for_lambda_iterations;
        counter = counter + 1;
    end
        %% Christina PLOT MSE
        if(SHOW_MSE_ANALYTICS == true)
            figure, plot(lambdas, mse), title('MSE(LAMBDA)'), xlabel('LAMBDA'), ylabel('MSE');
            figure, plot(lambdas, psnr), title('PSNR(LAMBDA)'), xlabel('LAMBDA'), ylabel('PSNR');
        end
        %% END Christina PLOT MSE
    %% Christina Lambda Iterations %%
end

