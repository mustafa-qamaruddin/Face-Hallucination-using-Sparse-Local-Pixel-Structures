function [ output_args ] = mqReconstruct( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

X = 11; Y = 18;
W = struct2array(load('OMEGA'));

%% to be calculated from low resolution input image and target high resolution %%
global DOWNSAMPLING;
DOWNSAMPLING = 128 / 16;
global SCALEFACTOR;
SCALEFACTOR = 0.05;
global NUMBERITERATIONS;
NUMBERITERATIONS = 150;

%%% INTERPOLATED LOW RESOLUTION FACE %%%
%%I0 = INITIAL_FACE(X, Y)
I0 = 0;

end

