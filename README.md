# Project Title : Diagnosis of Brain Tumor based on Moments of Local Binary Patterns and Discrete Wavelet Transform  

## Abstract
Diagnosis of brain tumor based on moments of local binary patterns and discrete wavelet transform from MRI images

## Proposed Method
1. Pre-processing ( de-noising and resizing to 300×300)
2. Feature extraction
   
  •	Apply DWT on pre-processed image

  •	Apply LBP on each sub band of DWT

  •	Apply moment on each sub band of previous step

3. Feature Classification using SVM( Normal or Abnormal)


## Dataset
Clinical dataset  ( 1000 MRI normal images, 1000 MRI abnormal images, 70% for training, 30% for testing)


## Results
The experimental results show that the proposed method has an accuracy of over 86% on clinical dataset

## How to Use
1.	Press train dataset button
2.	Then click open image for test
3.	Click feature extraction button
4.	Then click recognition button
5.	If tumor image is abnormal (malignant and benign) Click tumor segmentation button


## Project History
This project was originally completed in 2011. The commit history has been adjusted to reflect the original dates of the work.
