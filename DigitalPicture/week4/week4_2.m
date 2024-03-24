clear; close all; clc;
% pic=rgb2gray(imread('work1.png'));  % 统一单通道
pic=imread('work1.png');

%% 1:直方图均衡

% original
figure;
subplot(3,2,1);imshow(pic);title('Original');
subplot(3,2,2);imhist(pic);title('Histogram'); 

% histeq
pic_eq = histeq(pic, 256);
subplot(3,2,3);imshow(pic_eq);title('Original-eq');
subplot(3,2,4);imhist(pic_eq);title('Histogram-eq');
% imwrite(pic_eq,"pic_eq.png");

% histeq_handwrite
[num,pic_hand]=histeq_zry(pic);
subplot(3,2,5);imshow(pic_hand);title('Original-hand');
subplot(3,2,6);imhist(pic_hand);title('Histogram-hand');
% imwrite(pic_eq,"pic_hand.png");

%% 2:直方图匹配（规定化）

% histeq
pic_eq = histeq(pic, 256);
figure;
subplot(3,2,1);imshow(pic_eq);title('Original-eq');
subplot(3,2,2);imhist(pic_eq);title('Histogram-eq');

line = linspace(0,1,256); 
pic_line = histeq(pic, line);
subplot(3,2,3);imshow(pic_line);title('Original-line');
subplot(3,2,4);imhist(pic_line);title('Histogram-line');
% imwrite(pic_line,"pic_line.png");

t=[0:1/255:1];
x=sin(pi*t);
pic_sin = histeq(pic, x);
subplot(3,2,5);imshow(pic_sin);title('Original-sin');
subplot(3,2,6);imhist(pic_sin);title('Histogram-sin');
% imwrite(pic_sin,"pic_sin.png");