function [ output_args ] = mq_normalizeWeightsWarpingErrors( input_args )
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
warping_weights_dir_path = uigetdir;
warping_files = dir(strcat(warping_weights_dir_path, '\*.txt'));
num_files = length(warping_files);

%% LOOP K WARPING FILES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
b = cell(num_files, 1);
for i = 1 : num_files
    %% FILE READ %%
    file_name = warping_files(i).name;
    b{i} = dlmread(strcat(warping_weights_dir_path ,'\', file_name));
end

%% LOOP SENTIMENTS %%
w = size(b{1}, 1);
h = size(b{1}, 2);

%% B := DIAGONAL WARPING WEIGHTS MATRIX REFER TO PAPER %%
B = cell(w, h, 1);

%% OUTER LOOP ALL PIXELS %%
for x = 1 : w
    for y = 1 : h
        %% INNER LOOP ALL K WARPING WEIGHTS %%
        scaling_denominator = 0;
        for k = 1 : num_files
            scaling_denominator = scaling_denominator + b{k}(x,y);
        end
        %% END INNER LOOP %%
        
        %% INNER LOOP ALL K WARPING WEIGHTS %%
        diagonal_temp = zeros(num_files, num_files);
        for k = 1 : num_files
            diagonal_temp(k, k) = b{k}(x,y) / scaling_denominator; 
        end
        %% END INNER LOOP %%
        
        B{x,y} = diagonal_temp;
    end
end
%% END OUTER LOOP %%
save B.mat B;
end