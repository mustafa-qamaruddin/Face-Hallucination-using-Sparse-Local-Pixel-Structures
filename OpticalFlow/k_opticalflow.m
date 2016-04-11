function [ output_args ] = k_opticalflow( interpolated_low_res, training_high_res )
%MQ_OPTICALFLOW Summary of this function goes here
%   Detailed explanation goes here

    %% ## BEGIN VALIDATION ##
    %% check same size as interpolated low res image
    test_width = size(interpolated_low_res,1);
    test_height = size(interpolated_low_res,2);
    training_width = size(training_high_res, 1);
    training_height = size(training_high_res, 2);
    if( test_width ~= training_width || test_height ~= training_height)
        %% throw error
    end
    
    %% CALCULLATE FLOW
    opticFlow = opticalFlowHS('MaxIteration',20,'VelocityDifference',0);
    %% sets previous frame to black %%
    reset(opticFlow);
    %% INTERPOLATED LOW RES IMAGE
    frameGray = rgb2gray(interpolated_low_res);
    estimateFlow(opticFlow, frameGray);
    
    %% HIGH RES TRAINING IMAGE
    frameGray = rgb2gray(training_high_res);
    flow = estimateFlow(opticFlow, frameGray);
    
    %% PLOT FLOW
    figure, imshow(frameGray), title('Kth HIGH RES TRAINING IMAGE');
    hold on
    figure, plot(flow,'DecimationFactor',[10 10],'ScaleFactor',10), title('FLOW MAGNITUDE')
    hold off
    
    %% RETURN MAGNITUDE
    output_args = flow.Magnitude;
end

