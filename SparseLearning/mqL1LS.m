function [ output_args ] = mqL1LS( input_args )
global VISUALIZE;
VISUALIZE = true;
    ALL_As = load('overcomplete_dictionary_for_all_patches.mat');
    ALL_IPSAYs = load('central_pixels_for_all_patches.mat');
    ALL_As = struct2array(ALL_As);
    ALL_IPSAYs = struct2array(ALL_IPSAYs);
    num_of_patches = size(ALL_As,1);
    coefficients_omega = cell(num_of_patches, 1);
    for p = 1 : num_of_patches
        A = ALL_As(p)
        X0 = ALL_IPSAYs(p)
        if(isempty(A) == false && isempty(X0) == false)
            A = cell2mat(A);
            X0 = cell2mat(X0);
            OMEGA = zeros(size(X0, 1), 1);
            y  = A*X0;          % measurements with no noise
            lambda = 0.01;      % regularization parameter
            rel_tol = 0.01;     % relative target duality gap
            [OMEGA,status]=l1_ls_nonneg(A,y,lambda,rel_tol)
            coefficients_omega{p} = OMEGA;
            if(VISUALIZE == true && strcmp(status, 'Solved'))
                figure(1)
                subplot(2,1,1); bar(X0); ylim([0 255]); title('original signal x0');
                subplot(2,1,2); bar(OMEGA);  ylim([0 255]); title('reconstructed signal x');
            end %% end if solved
        end %% end if patch is not empty
    end %% end loop patches
    save 'coefficients_omega_for_all_patches' coefficients_omega;
end

