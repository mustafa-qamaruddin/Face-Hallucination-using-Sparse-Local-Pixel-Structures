function [ output_args ] = mqTestReverseL1LS( ipsay, ipsay_hat )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    hold on
    figure(1)
    subplot(3,1,1); bar(ipsay); ylim([0 255]); title('original signal ipsay');
    subplot(3,1,2); bar(ipsay_hat);  ylim([0 255]); title('reconstructed signal ipsay hat');
    error = zeros(size(ipsay, 1), 1);
    for i = 1 : size(ipsay, 1)
        error(i) = abs(ipsay(i) - ipsay_hat(i));
    end
    subplot(3,1,3); bar(error);  ylim([0 5]); title('error between ipsay and ipsay hat');
    hold off
end

