function [ret] = immse(lena, image_new);
[M, N] = size(lena);
error = lena - (image_new);
MSE = sum(sum(error .* error)) / (M * N);
ret = MSE(1,1,1)
end