function [ Dictionary ] = mq_buildOverCompleteDictionary( K, patch_size )
%OVERCOMPLETEDIC Summary of this function goes here
%   get centeral pixels and put them in vector[center]
%   get the neigbours and put them in matrix[neighbours]

%% NUMBER OF IMAGES IN K MATRIX% 
k = size(K,1);
%%
center = 0; %% Vector for all CENTERs %%
neighbours = zeros(0,(patch_size*patch_size)-1); %% P^2 - 1 %%

%%

%%% LOOP ALL IMAGES %%%
for i=1:k
    %%% LOOP ALL PATCHES %%%
    patches = reshape(K(i),[1,size(K(i),1)*size(K(i),2)]);
    for p=1:length(patches) %% NUMBER OF PATCHES IN EACH IMAGE %%
       patch = K(p); %% Returns Cell from the Array of Matrices K %%
       unrolledPatch = reshape(patch,[1,patch_size*patch_size]); %% reshape patch from matrix to vector %%
       patch_center = ceil(length(unrolledPatch) / 2); %% get center pixel %%
       center(size(center,1)+1) = unrolledPatch(patch_center) %% append center to vector %%
       neighbours(size(neighbours,1)+1,:) = unrolledPatch([1:24 26:end]); %% all neighbors %%
    end
end

Dictionary = [center(2:end,:) neighbours(2:end,end)];

save dictionary.m Dictionary