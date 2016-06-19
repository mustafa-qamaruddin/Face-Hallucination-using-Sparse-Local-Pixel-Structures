function [cell_k_patches] = mqSplitImg2PatchesV2(k_images, patch_size, overlap)
global VISUALS;
    %% loop images
    for k = 1 : size(k_images)
        im = k_images{k};
        num_patches = size(im, 1) * size(im, 2);
        
        patches = cell(num_patches, 1);
        patches_counter = 1;
        
        %% PADDING $$
        offset=floor(patch_size/2);
        im = padarray(im, [offset offset]);
        %% visualize
        if(VISUALS == true)
            obj_shape_insert = vision.ShapeInserter('BorderColor', 'Custom', 'CustomBorderColor', [46 139 0]);
            visual_im = im;
        end
        %% loop rows
        fin_row = size(im, 2) - offset;
        for c = offset+1 : fin_row
            %% loop cols
            fin_col = size(im, 1) - offset;
            for r = offset+1 : fin_col
                patches{patches_counter} = im([r-offset:r+offset], [c-offset:c+offset]);
                %% visualize
                if(VISUALS == true)
                    visual_im = step(obj_shape_insert, visual_im, int32([r c patch_size patch_size]));
                    figure(k), imshow(visual_im), title(sprintf('%dth nearest image', k));
                end
                %% increment inner most loop counters
                patches_counter = patches_counter + 1;
            end %% end loop columns
        end %% end loop rows
        file_name = sprintf('patches/%d.mat', k);
        save(file_name,'patches');
        if(VISUALS == true)
            figure(k), imshow(visual_im), title(sprintf('%dth nearest image', k));
        end
    end %% end loop images
end