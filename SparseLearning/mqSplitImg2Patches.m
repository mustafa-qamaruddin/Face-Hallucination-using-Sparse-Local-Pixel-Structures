function [cell_k_patches] = mqSplitImg2Patches(k_images, patch_size, overlap)
    %% loop images
    for k = 1 : size(k_images)
        im = k_images{k};
        num_patches = ceil((size(im, 1) * size(im, 2)) / (patch_size * patch_size))
        patches = cell(num_patches, 1);
        patches_counter = 1;
        %% visualize
        obj_shape_insert = vision.ShapeInserter('BorderColor', 'Custom', 'CustomBorderColor', [46 139 87]);
        visual_im = im;
        %% loop rows
        fin_row = size(im, 1) - patch_size;
        for r = 1 : fin_row
            %% loop cols
            fin_col = size(im, 2) - patch_size;
            for c = 1 : fin_col
                patches{patches_counter} = im([r:r+patch_size-1] , [c:c+patch_size-1]);
                %% visualize
                visual_im = step(obj_shape_insert, visual_im, int32([r c patch_size patch_size]));
                %% increment inner most loop counters
                patches_counter = patches_counter + 1;
                c = c + patch_size;
            end %% end loop columns
            r = r + patch_size;
        end %% end loop rows
        file_name = sprintf('patches/%d.mat', k);
        save(file_name,'patches');
        figure, imshow(visual_im), title(sprintf('%dth nearest image', k));
    end %% end loop images
end