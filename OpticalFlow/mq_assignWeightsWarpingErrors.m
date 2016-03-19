function [ output_args ] = mq_assignWeightsWarpingErrors( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%
%%  CONSTANTS SHOULD BE PASSED AS FUNCTION ARGUMENtS
%%  OR MOVE TO FUNCTION mqSetGlobals.m
%%
global PATCH_WIDTH;
global PATCH_HEIGHT;
global EPSILON;
global BETA;
%% mqInitGlobals %%
PATCH_WIDTH = 9;
PATCH_HEIGHT = 9;
EPSILON = 0.009;
BETA = 0.009;
%% END CONSTANTS %%

%% WARPING FILE IO
warping_error_dir_path = uigetdir;
warping_files = dir(strcat(warping_error_dir_path, '\*.txt'));
num_files = length(warping_files);

%% LOOP K WARPING FILES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
for i = 1 : num_files
    %% FILE READ %%
    file_name = warping_files(i).name;
    warping_error_matrix = dlmread(strcat(warping_error_dir_path ,'\', file_name));
    %% PROCESS %%
    b_k = mqCalculateWeightsWarpingErrors(warping_error_matrix);
    %% FILE WRITE %%
    file_name = sprintf('warping_weights/%d.txt', i);
    dlmwrite(file_name, b_k);
end

end