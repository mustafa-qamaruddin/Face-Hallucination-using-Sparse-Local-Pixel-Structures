function [output_args] = mqCalculateWeightsWarpingErrors(Er_k)

    %% USE GLOBALS %%
    global PATCH_SIZE;
    PATCH_WIDTH = PATCH_SIZE;
    PATCH_HEIGHT = PATCH_SIZE;
    global EPSILON;
    global BETA;

    %% MATRIX DIMENSION %%
    image_width = size(Er_k, 1);
    image_height = size(Er_k, 2);
   
    %% HALF PATCH OFFSET %%
    offset_w = floor(PATCH_WIDTH/2);
    offset_h = floor(PATCH_HEIGHT/2);
    
    %% PADDING %%
    PADDED_Er_k = padarray(Er_k, [offset_w offset_h]);
    
    %% OUTER LOOP PIXELS %%
    b_k = padarray(zeros(image_width, image_height), [offset_w offset_h]);
    
    %% SET LOOP SENTIMENTS %%
    x_0 = 1 + offset_w;
    x_n = image_width + offset_w;
    y_0 = 1 + offset_h;
    y_n = image_height + offset_h;
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    for x = x_0 : x_n
        for y = y_0 : y_n
            %% INNER LOOP PATCH NEIGHBORS %%
            for i = -offset_w : offset_w
                for j = -offset_h : offset_h
                    b_k(x,y) = b_k(x,y) + PADDED_Er_k(x + i, y + j);
                end
            end
            %% END INNER LOOP %%
            b_k(x,y) = power(b_k(x,y) + EPSILON, BETA);
        end
    end
    
    %%% END OUTER LOOP %%
    
    %% REMOVE PADDING %%
    output_args = b_k(x_0:x_n, y_0:y_n);
end