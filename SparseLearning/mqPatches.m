function [ output_args ] = mqPatches( input_args )
%MQ_TES Summary of this function goes here
%   Detailed explanation goes here
PATCH_WIDTH = 7;
PATCH_HEIGHT = 7;
%% ## BEGIN READ K NEAREST HIGH RES IMAGE ##

%% IMAGE FILE IO
lowres_dir_path = uigetdir;
image_files = dir(strcat(lowres_dir_path, '\*.bmp'));
num_files = length(image_files);

%% LOOP K IMAGES
%% Consider preallocating a variable or array 
%% before entering the loop by using zeros, ones, cell, or a similar
%% function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       SAVE PATCHES FROM IMAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_patches = cell(num_files, 1);
IPSAY = zeros(num_files, 1); %% Central Pixels
CC = ceil(PATCH_WIDTH / 2);
CR = ceil(PATCH_HEIGHT / 2);
for i = 1 : num_files
    file_name = image_files(i).name;
    training_image = imread(strcat(lowres_dir_path ,'\', file_name));
    
    %% loop to make patches %%
    %% loop to build central pixels vector %%
    ii = 8; %% patch index till we build the loop
    jj = 15; %% patch index till we build the loop
    k_patches{i} = training_image(ii*1:ii*1+PATCH_WIDTH-1, jj*1:jj*1+PATCH_HEIGHT-1);
    %% k_patches{i} save patch to file variable work space
    IPSAY(i) = k_patches{i}(CR, CC);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          reshape patch as vector          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PSQ = PATCH_WIDTH * PATCH_HEIGHT;
PSQ_1 = PSQ - 1;
A = zeros(num_files, PSQ_1); %% Dictionary for a single Patch
%% LOOP ALL K PATCHES %%
vec_patches = zeros(num_files, PSQ_1);
for i = 1 : num_files
    temp = reshape(k_patches{i}, 1, PSQ);
    len = size(temp, 2);
    cen_left = floor(size(temp, 2) / 2);
    cen_right = ceil(size(temp, 2) / 2) + 1;
    temp_left = temp(1, 1:cen_left);
    temp_right = temp(1, cen_right:len);
    A(i, :) = transpose([temp_left temp_right]);
end
%% END LOOP %%
%%%%%%%%%%%%%%%%%%%%%%%%%
A = transpose(A);
%% ## END READ K NEAREST HIGH RES IMAGE ##
save A.mat A
save IPSAY.mat IPSAY
end