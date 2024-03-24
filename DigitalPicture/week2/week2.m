clear; close all; clc;
pic=imread('pic2.jpg');

%% RGB
pic_R=pic(:,:,1);
pic_G=pic(:,:,2);
pic_B=pic(:,:,3);

%% CMY
% pic_cmy = imcomplement(pic);
pic_C=256-pic_R;
pic_M=256-pic_G;
pic_Y=256-pic_B;

%%  HSI
pic_hsi = rgb2hsi(pic);
pic_H=pic_hsi(:,:,1);
pic_S=pic_hsi(:,:,2);
pic_I=pic_hsi(:,:,3);

figure;
subplot(3,3,1);imshow(pic_R);
subplot(3,3,2);imshow(pic_G);
subplot(3,3,3);imshow(pic_B);
subplot(3,3,4);imshow(pic_C);
subplot(3,3,5);imshow(pic_M);
subplot(3,3,6);imshow(pic_Y);
subplot(3,3,7);imshow(pic_H);
subplot(3,3,8);imshow(pic_S);
subplot(3,3,9);imshow(pic_I);