function[out] = mqGlueWarping()
    mq_opticalflow_test();
    mq_assignWeightsWarpingErrors();
    mq_normalizeWeightsWarpingErrors();
    mqRefineWarpingError();
end