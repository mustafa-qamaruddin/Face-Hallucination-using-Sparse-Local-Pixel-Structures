%
%   simple example to show the usage of l1_ls
%

% problem data
A  = load('A.mat');
x0 = load('IPSAY.mat');    % original signal
%% dereference cell array contents %%
A = struct2array(A);
x0 = struct2array(x0);
y  = A*x0;          % measurements with no noise
lambda = 0.01;      % regularization parameter
rel_tol = 0.01;     % relative target duality gap

[OMEGA,status]=l1_ls(transpose(A),x0,lambda,rel_tol);

save OMEGA.mat OMEGA