function[out] = mqRefineWarpingError(B)

    %% display graphs
    global VISUALS;

    %% consider padding in original test image
    global PATCH_SIZE;
    offset=floor(PATCH_SIZE/2);

    %% load Normalized Warping Weights Matrix
    %%B = load('B.mat');
    %%B = struct2array(B);
    
    %% load central pixels
    ALL_IPSAYs = load('central_pixels_for_all_patches.mat');
    ALL_IPSAYs = struct2cell(ALL_IPSAYs);
    
    %% load overcomplete dictionaries
    ALL_As = load('overcomplete_dictionary_for_all_patches.mat');
    ALL_As = struct2cell(ALL_As);
    
    %% load sparse coefficients omega
    ALL_OMEGAS = load('coefficients_omega_for_all_patches.mat');
    ALL_OMEGAS = struct2cell(ALL_OMEGAS);
    
    %% initialize empty matrix for refined coefficents
    num_of_patches = size(ALL_As,1);
    refined_coefficients_omega = cell(num_of_patches, 1);
    
    %% loop all pixels
    counter = 1; %% patch counter
        %% loop rows
        fin_row = size(B, 2) - offset;
        for c = offset+1 : fin_row
            %% loop cols
            fin_col = size(B, 1) - offset;
            for r = offset+1 : fin_col
                %% one pixel calculations
                A = ALL_As(counter);
                IPSAY = ALL_IPSAYs(counter);
                OMEGA = ALL_OMEGAS(counter);
                B_xy = B(r, c);
                
                %% extract cell to matrix cell2mat
                A = cell2mat(A{1});
                IPSAY = cell2mat(IPSAY{1});
                OMEGA = cell2mat(OMEGA{1});
                B_xy = cell2mat(B_xy);
                
                IPSAY_HAT = transpose(A) * OMEGA;
                
                nominator = transpose(IPSAY_HAT) * B_xy * IPSAY;
                denominator = transpose(IPSAY) * B_xy * IPSAY;
                EPSILON = 0.01;
                
                C_xy = nominator / (denominator + EPSILON);
                
                %% Refine Coefficients
                OMEGA_HAT = C_xy * OMEGA;
                if(VISUALS == true)
                    new_ipsay_hat = transpose(A)*OMEGA_HAT;
                    mqTestReverseL1LS(IPSAY, new_ipsay_hat);
                end %% end if solved
                
                refined_coefficients_omega{counter} = OMEGA_HAT;
            end
        end
    save 'refined_coefficients_omega_for_all_patches' refined_coefficients_omega;
end