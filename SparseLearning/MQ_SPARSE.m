P = 3; %% patch size
K = 5; %% number of nearest neighbors

IPSAY = zeros(M, N);
%% foreach pixel in original high-res image
%% foreach patch

A = zeros(P, P); %% neighboring vectors
OMEGA = zeros(P,P); %% weights of neighboring pixels[zeros except for central xxxvectorsxxxx
IPSAY_Element = zeros(K, 1); %% coefficients matrix
IPSAY_Element = OMEGA * A;