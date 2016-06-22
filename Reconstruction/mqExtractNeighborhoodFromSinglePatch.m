function [neighborhood] = mqExtractNeighborhoodFromSinglePatch(patch, patch_size)

    PSQ = patch_size * patch_size;
    PSQ_1 = PSQ - 1;
    SINGLE_PATCH_A = zeros(PSQ_1, 1);
    if (isempty(patch) == false)
        temp = reshape(patch, 1, PSQ);
        len = size(temp, 2);
        cen_left = floor(size(temp, 2) / 2);
        cen_right = ceil(size(temp, 2) / 2) + 1;
        temp_left = temp(1, 1:cen_left);
        temp_right = temp(1, cen_right:len);
        SINGLE_PATCH_A = transpose([temp_left temp_right]);
    end
    neighborhood = SINGLE_PATCH_A;
    
end