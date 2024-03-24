clear; close all; clc;
% pic=rgb2gray(imread('work1.png'));  % 统一单通道
pic=imread('A_gray.jpg');  % 先用单通道灰度图来试验
H=3;W=2;
pic_histeq=histeq(pic,256);
pic_histeq_try=histeq_try(pic,256);
figure;
a=imhist(pic);
b=imhist(pic_histeq);
c=imhist(pic_histeq_try);
[vari(a),vari(b),vari(c)]
subplot(H,W,1);imshow(pic);title("A");
subplot(H,W,2);imhist(pic);title("A");
subplot(H,W,3);imshow(pic_histeq);title("A-histeq");
subplot(H,W,4);imhist(pic_histeq);title("A-histeq");
subplot(H,W,5);imshow(pic_histeq_try);title("A-histeq-try");
subplot(H,W,6);imhist(pic_histeq_try);title("A-histeq-try");
