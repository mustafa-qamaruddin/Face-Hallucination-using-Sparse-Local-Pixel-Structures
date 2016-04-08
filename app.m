%% APPLICATION ENTRY POINT %%
global PATCH_SIZE;
PATCH_SIZE = 7;
global PATCH_OVERLAP;
PATCH_OVERLAP = 0;
global VISUALS;
VISUALS = false;
%% STEP 1 %%
%#mqSaveKImages();
%% STEP 2 %%
KIMAGES = struct2cell(load('kimages.mat'));
mqSplitImg2PatchesV2(KIMAGES{1}, PATCH_SIZE, PATCH_OVERLAP);

mqBuildCentralPixels(size(KIMAGES{1}, 1), PATCH_SIZE);
mqBuildOverCompleteDictionary(size(KIMAGES{1}, 1), PATCH_SIZE);
mqL1LS();
%% STEP 3 $$