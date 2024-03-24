%% 探究多通道图像、直方图均衡化、RGB的关系
clear; close all; clc;
pic=imread('A.jpg');
[h,w,~]=size(pic);
H=5;W=2;
pic_gray=rgb2gray(pic);
pic_hsi=rgb2hsi(pic);
pic_hist=histeq(pic);
pic_hist_rgb=pic;
pic_hist_rgb(:,:,1)=histeq(pic(:,:,1));
pic_hist_rgb(:,:,2)=histeq(pic(:,:,2));
pic_hist_rgb(:,:,3)=histeq(pic(:,:,3));
pic_median=pic_gray;
pic_add=zeros(h,3*w,'uint8');
for i=1:h  % 求pdf(个数)
   for j=1:w
       pic_median(i,j)=median(pic(i,j));
       pic_add(i,3*j-2)=pic(i,j,1);
       pic_add(i,3*j-1)=pic(i,j,2);
       pic_add(i,3*j)=pic(i,j,3);
    end
end

figure;
% subplot(H,W,1);imshow(pic);title('Original');
subplot(H,W,1);imhist(pic);title('Histogram'); 
% subplot(H,W,3);imshow(pic_hist);title('eq-Original');
% subplot(H,W,4);imhist(pic_hist);title('eq-Histogram'); 
% % subplot(H,W,5);imshow(pic_hist_rgb);title('eqrgb-Original');
% subplot(H,W,6);imhist(pic_hist_rgb);title('eqrgb-Histogram'); 
subplot(H,W,2);imhist(pic_gray);title('gray-Histogram');
subplot(H,W,3);imhist(pic(:,:,1));title('r-Histogram');
subplot(H,W,4);imhist(pic(:,:,2));title('g-Histogram');
subplot(H,W,5);imhist(pic(:,:,3));title('b-Histogram');
subplot(H,W,6);imhist(pic_hsi(:,:,1));title('h-Histogram');
subplot(H,W,7);imhist(pic_hsi(:,:,2));title('s-Histogram');
subplot(H,W,8);imhist(pic_hsi(:,:,3));title('i-Histogram');  % average
subplot(H,W,9);imhist(pic_median);title('median-Histogram');
subplot(H,W,10);imhist(pic_add);title('add-Histogram');
