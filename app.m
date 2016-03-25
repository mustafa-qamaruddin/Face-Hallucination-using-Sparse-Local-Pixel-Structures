%% APPLICATION ENTRY POINT %%
global PATCH_SIZE;
PATCH_SIZE = 7;
%% STEP 1 %%

%% STEP 2 %%
KIMAGES = struct2cell(load('kimages.mat'));
mqSplitImg2Patches(KIMAGES{1}, PATCH_SIZE, 0)
mqBuildCentralPixels(KIMAGES{1})

%% STEP 3 $$