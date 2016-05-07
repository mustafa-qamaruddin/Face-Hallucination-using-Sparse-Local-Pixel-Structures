%% INPUTS:
%%  K := numberf of nearest neighbors
%% OUTPUTS:
%%  CELL OF IPSAY VECTORS OF CENTRAL PIXELS OF ALL PATCHES IN K IMAGES
function [ output_args ] = mqBuildCentralPixels( NUM_NEAREST_NEIGHBORS , PATCH_SIZE)
    %% assume training set is all same size & same # of patches
    k_patches = cell(NUM_NEAREST_NEIGHBORS, 1);
    for k = 1 : NUM_NEAREST_NEIGHBORS
        file_name = sprintf('patches/%d.mat', k);
        k_patches{k} = load(file_name);
        kth_image_patches = k_patches{k}(1);
        k_patches{k} = kth_image_patches(1);
    end
    
    %% start building
    temporary_cell = struct2cell(k_patches{1});
    num_of_patches = size(temporary_cell{1}, 1);
    k_patches = cell2mat(k_patches);
    IPSAY = cell(num_of_patches, 1); %% Central Pixels
    CC = ceil(PATCH_SIZE / 2);
    CR = ceil(PATCH_SIZE / 2);
    for j = 1 : num_of_patches
        SINGLE_PATCH_IPSAY = zeros(NUM_NEAREST_NEIGHBORS, 1);
        for i = 1 : NUM_NEAREST_NEIGHBORS
            temporary_cell = k_patches(i);
            temporary_array = struct2cell(temporary_cell);
            temporary_x = temporary_array{1};
            patch = temporary_x{j};
            if (isempty(patch) == false)
                SINGLE_PATCH_IPSAY(i) = patch(CR, CC);
            end
        end
        IPSAY{j} = SINGLE_PATCH_IPSAY;
    end
    save 'central_pixels_for_all_patches.mat' IPSAY;
end