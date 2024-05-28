clc;close all; clear all;
rgbimage=imread('a.b.1.jpg');
rgbimage=rgb2gray(rgbimage);
rgbimage=im2double(rgbimage);
figure;imshow(rgbimage);
rgbimage=imresize(rgbimage,[256,256]);
 [h_LL,h_LH,h_HL,h_HH]=dwt2(rgbimage,'haar');
% figure;imshow(h_LL);
% figure;imshow(h_LH);
% figure;imshow(h_HL);
% figure;imshow(h_HH);

SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
% h_LL_lbp=lbp(h_LL,SP,0,'i'); 
h_LH_lbp=lbp(h_LH,SP,0,'i'); 
h_HL_lbp=lbp(h_HL,SP,0,'i'); 
h_HH_lbp=lbp(h_HH,SP,0,'i'); 


h_LH_lbp=imresize(h_LH_lbp,[128 128]);
figure;imshow(h_LH_lbp);
h_LH_lbp=im2double(h_LH_lbp);
h_LH_lbp_mom=lmom(h_LH_lbp,3);

h_HL_lbp=imresize(h_HL_lbp,[128 128]);
figure;imshow(h_HL_lbp);
h_HL_lbp=im2double(h_HL_lbp);
h_HL_lbp_mom=lmom(h_HL_lbp,3);

h_HH_lbp=imresize(h_HH_lbp,[128 128]);
figure;imshow(h_HH_lbp);
h_HH_lbp=im2double(h_HH_lbp);
h_HH_lbp_mom=lmom(h_HH_lbp,3);

feature_vector=cat(1,h_LH_lbp_mom,h_HL_lbp_mom,h_HH_lbp_mom);
feature_vector = reshape (feature_vector, 1, 390);
% axes(handles.axes2)  
% box on
% imshow(I2);