%% APPLICATION ENTRY POINT %%
global PATCH_SIZE;
PATCH_SIZE = 7;
global PATCH_OVERLAP;
PATCH_OVERLAP = 0;
global VISUALS;
VISUALS = true;
global LOW_RES_INPUT_TEST_IMAGE;
global HIGH_RES_INPUT_TEST_IMAGE; %% target

global OPTICAL_FLOW_ALGORITHM;
OPTICAL_FLOW_ALGORITHM = 0; %0:lucas_kanade , 1:horn_shunks

global SHOW_MSE_ANALYTICS;
SHOW_MSE_ANALYTICS = true;

global NUMBER_NEAREST_NEIGHBORS;

%% STEP 1 %%
loadInputImage();
mqPCA();
mqSaveKImages();

%% STEP 2 %%
KIMAGES = struct2cell(load('kimages.mat'));
mqSplitImg2PatchesV2(KIMAGES{1}, PATCH_SIZE, PATCH_OVERLAP);

mqBuildCentralPixels(size(KIMAGES{1}, 1), PATCH_SIZE);
mqBuildOverCompleteDictionary(size(KIMAGES{1}, 1), PATCH_SIZE);

%% Large-Scale Regularized Least Squares
mqL1LS();

%% warping errors effect on coefficients omega
mqGlueWarping(KIMAGES{1});

%% STEP 3 $$
if(SHOW_MSE_ANALYTICS == true)
        mqReconstruct(0.05);
else
        mqReconstruct(0.05);
end