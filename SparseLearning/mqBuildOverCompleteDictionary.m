%% INPUTS:
%%  K := numberf of nearest neighbors
%% OUTPUTS:
%%  CELL OF OVERCOMPLETE DICTIONARY OF ALL PATCHES IN K IMAGES
function [ output_args ] = mqBuildOverCompleteDictionary(NUM_NEAREST_NEIGHBORS , PATCH_SIZE)
    %% assume training set is all same size & same # of patches
    k_patches = cell(NUM_NEAREST_NEIGHBORS, 1);
    for k = 1 : NUM_NEAREST_NEIGHBORS
        file_name = sprintf('patches/%d.mat', k);
        k_patches{k} = load(file_name);
        kth_image_patches = k_patches{k}(1);
        k_patches{k} = struct2array(kth_image_patches(1));
    end
    
    %% start building
    num_of_patches = size(k_patches{1}, 1);
    A = cell(num_of_patches, 1); %% Central Pixels
    PSQ = PATCH_SIZE * PATCH_SIZE;
    PSQ_1 = PSQ - 1;
    for j = 1 : num_of_patches
        %% Dictionary for a single Patch
        SINGLE_PATCH_A = zeros(NUM_NEAREST_NEIGHBORS, PSQ_1);
        for i = 1 : NUM_NEAREST_NEIGHBORS
            patch = cell2mat(k_patches{i}(j));
            if (isempty(patch) == false)
                temp = reshape(patch, 1, PSQ);
                len = size(temp, 2);
                cen_left = floor(size(temp, 2) / 2);
                cen_right = ceil(size(temp, 2) / 2) + 1;
                temp_left = temp(1, 1:cen_left);
                temp_right = temp(1, cen_right:len);
                SINGLE_PATCH_A(i, :) = transpose([temp_left temp_right]);
            end
        end
        A{j} = transpose(SINGLE_PATCH_A);
    end
    save 'overcomplete_dictionary_for_all_patches.mat' A;
end