function [image] = asBicubicInterpolation(InputImage,width , height)
image = imresize(InputImage,[width,height]);
end