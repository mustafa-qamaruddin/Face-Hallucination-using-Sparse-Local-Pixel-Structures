function[out] = mqGlueWarping(k_images)
    cell_warping_errors = mq_opticalflow_test(k_images);
    cell_warping_weights = mq_assignWeightsWarpingErrors(cell_warping_errors);
    B = mq_normalizeWeightsWarpingErrors(cell_warping_weights);
    mqRefineWarpingError(B);
end