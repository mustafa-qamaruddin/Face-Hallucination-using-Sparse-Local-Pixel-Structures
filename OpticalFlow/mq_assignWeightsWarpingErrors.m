function [ output_args ] = mq_assignWeightsWarpingErrors( cell_warping_errors )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%%
%%  CONSTANTS SHOULD BE PASSED AS FUNCTION ARGUMENtS
%%  OR MOVE TO FUNCTION mqSetGlobals.m
%%
global PATCH_SIZE;

global EPSILON;
global BETA;

%% mqInitGlobals %%
PATCH_WIDTH = PATCH_SIZE;
PATCH_HEIGHT = PATCH_SIZE;

EPSILON = 0.009;
BETA = 0.009;
%% END CONSTANTS %%

%% WARPING FILE IO
%%//warping_error_dir_path = uigetdir;
%%//warping_files = dir(strcat(warping_error_dir_path, '\*.txt'));
num_files = size(cell_warping_errors, 1);

%% LOOP K WARPING FILES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
cell_warping_weights = cell(num_files, 1);
for i = 1 : num_files
    %% FILE READ %%
    %%file_name = warping_files(i).name;
    %%warping_error_matrix = dlmread(strcat(warping_error_dir_path ,'\', file_name));
    %% PROCESS %%
    cell_warping_errors{i};
    b_k = mqCalculateWeightsWarpingErrors(cell_warping_errors{i});
    %% FILE WRITE %%
    %%file_name = sprintf('warping_weights/%d.txt', i);
    %%dlmwrite(file_name, b_k);
    cell_warping_weights{i} = b_k;
end
output_args = cell_warping_weights;
end