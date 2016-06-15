# Face Hallucination using Sparse Local Pixel Structures
#### This repository includes a MatLab implementation of the algorithm manifested 
[Li et al. 2014](http://dl.acm.org/citation.cfm?id=2563012)


##### Authors:
--------------
Yongchao Li
###### Department of Computer Science, College of Information Engineering, Northwest A&F University, Xi'an, China
Cheng Cai
###### Department of Computer Science, College of Information Engineering, Northwest A&F University, Xi'an, China
Guoping Qiu
###### International Doctoral Innovation Centre, The University of Nottingham, Ningbo, China
Kin-Man
###### Lami Department of Electronic and Information Engineering, Hong Kong Polytechnic University, Hong Kong

##### Published in:
-------------------
Pattern Recognition archive
Volume 47 Issue 3, March, 2014 
Pages 1261-1270 
Elsevier Science Inc. New York, NY, USA

##### Configuration:
--------------------
All required parameters are configured via global variables decalred in app.m

##### Run:
----------
Run app.m which is the entry point of the program
Include image processing and computer vision toolboxes in Matlab
The steps are separated into their own functions and each function is in its own
.m file

##### Steps:
------------
The program does the following procedures in order:
1. PCA algorithm
2. KNN algorithm
3. Cut the images into patches
4. L1LS sparse learning on patches
5. Reconstruct the target high-resolution face image

##### Testing:
--------------
The program tests for accuracy using:
1. MSE 
2. PSNR
3. SSIM

The L1LS is tested by applying reverse equation Y^ = X' . A after obtaining X'
using L1LS, then Y^ is compared to Y

##### Contribution:
-------------------
Feel free to fork this repository and discuss the ideas with us in the issues
tab.
