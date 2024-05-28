clc;
clear all;
close all;
% a=imread('KA.AN3.41.TIF');
%  a=im2double(a);
% % a=rgb2gray(a);
% figure;imshow(a);
% m = moment(a,3);
% figure;imshow(m);
nL=3;
X=imread('KA.AN3.41.TIF');
 X=im2double(X);
[rows cols] = size(X);
if cols == 1 X = X'; end
n = length(X);
X = sort(X);
b = zeros(1,nL-1);
l = zeros(1,nL-1);
b0 = mean(X);

for r = 1:nL-1
    Num = prod(repmat(r+1:n,r,1)-repmat([1:r]',1,n-r),1);
    Den = prod(repmat(n,1,r) - [1:r]);
    b(r) = 1/n * sum( Num/Den .* X(r+1:n) );
end

tB = [b0 b]';
B = tB(length(tB):-1:1);

for i = 1:nL-1
    Spc = zeros(length(B)-(i+1),1);
    Coeff = [Spc ; LegendreShiftPoly(i)];
    l(i) = sum((Coeff.*B),1);
end

L = [b0 l];