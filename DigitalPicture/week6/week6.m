close all; clear; clc;
[image,map,alpha]=imread('image.png');
pic=ind2rgb(image,map);  % pic是double类型的图像，经验证知R=G=B，故转换为单通道灰度图
pic2=rgb2gray(pic); %  以下皆用pic2来操作
psnr=zeros(3,3);
[h,w]=size(pic2);
H1=2;W1=3;
H2=3;W2=3;
%% 加入噪声

% 高斯噪声  
% 试着改变均值和方差
Gauss=0+0.1*randn(h,w);  % 标准差是0.1
noise_gau=pic2+Gauss;  % 注意到imshow自身会将[0,1]以外的值截断
figure;
subplot(H1,W1,1);imshow(pic2);title('Original');
subplot(H1,W1,2);imshow(noise_gau);title('noise-Gaussian-randn');
noise_gau2=imnoise(pic2,'gaussian',0,0.01);  % 均值和方差
subplot(H1,W1,3);imshow(noise_gau2);title('noise-Gaussian-0-0.01');
subplot(H1,W1,4);imshow(imnoise(pic2,'gaussian',0,0.3));title('noise-Gaussian-0-0.3');
subplot(H1,W1,5);imshow(imnoise(pic2,'gaussian',0.3,0.01));title('noise-Gaussian-0.3-0.01');
subplot(H1,W1,6);imshow(imnoise(pic2,'gaussian',-0.3,0.01));title('noise-Gaussian--0.3-0.01');

% 椒盐噪声
% 试着改变密度
noise_sp=imnoise(pic2,'salt & pepper',0.1);  % 密度
figure;
subplot(2,2,1);imshow(pic2);title('Original');
subplot(2,2,2);imshow(noise_sp);title('noise-sp-0.1');
subplot(2,2,3);imshow(imnoise(pic2,'salt & pepper',0.4));title('noise-sp-0.4');
subplot(2,2,4);imshow(imnoise(pic2,'salt & pepper',0.7));title('noise-sp-0.7');

% 均匀噪声
noise_aver=imnoise(pic2,'speckle',0.05);  % 均匀分布的方差
figure;
subplot(1,2,1);imshow(pic2);title('Original');
subplot(1,2,2);imshow(noise_aver);title('noise-speckle');

figure;  % 直方图分析
subplot(2,2,1);imhist(pic2);title('Original');
subplot(2,2,2);imhist(noise_gau2);title('noise-Gaussian');
subplot(2,2,3);imhist(noise_sp);title('noise-sp');
subplot(2,2,4);imhist(noise_aver);title('noise-aver');

%% 滤波去噪（空域增强）

% 均值滤波
figure;
subplot(H2,W2,1);imshow(filter2(fspecial('average',5),noise_gau));title('Gau+Aver');
psnr(1,1)=PSNR(pic2,filter2(fspecial('average',5),noise_gau));
subplot(H2,W2,2);imshow(filter2(fspecial('average',5),noise_sp));title('sp+Aver');
psnr(1,2)=PSNR(pic2,filter2(fspecial('average',5),noise_sp));
subplot(H2,W2,3);imshow(filter2(fspecial('average',5),noise_aver));title('Aver+Aver');
psnr(1,3)=PSNR(pic2,filter2(fspecial('average',5),noise_aver));

% 中值滤波
subplot(H2,W2,4);imshow(medfilt2(noise_gau,[5 5]));title('Gau+medi');
psnr(2,1)=PSNR(pic2,medfilt2(noise_gau,[5 5]));
subplot(H2,W2,5);imshow(medfilt2(noise_sp,[5 5]));title('sp+medi');
psnr(2,2)=PSNR(pic2,medfilt2(noise_sp,[5 5]));
subplot(H2,W2,6);imshow(medfilt2(noise_aver,[5 5]));title('Aver+medi');
psnr(2,3)=PSNR(pic2,medfilt2(noise_aver,[5 5]));

% 高斯滤波
subplot(H2,W2,7);imshow(filter2(fspecial('gaussian',5,3),noise_gau));title('Gau+Gau');  % 后一个参数是方差（模糊程度）
psnr(3,1)=PSNR(pic2,filter2(fspecial('gaussian',5,3),noise_gau));
subplot(H2,W2,8);imshow(filter2(fspecial('gaussian',5,3),noise_sp));title('sp+Gau');
psnr(3,2)=PSNR(pic2,filter2(fspecial('gaussian',5,3),noise_sp));
subplot(H2,W2,9);imshow(filter2(fspecial('gaussian',5,3),noise_aver));title('Aver+Gau');
psnr(3,3)=PSNR(pic2,filter2(fspecial('gaussian',5,3),noise_aver));

%% 锐化增强（高频提升）

% Robert算子
Rob=pic2;
for i=2:h-1
    for j=2:w-1
        Rob(i,j)=abs(pic2(i+1,j+1)-pic2(i,j))+abs(pic2(i,j+1)-pic2(i+1,j));
    end
end
figure;
subplot(2,2,1);imshow(Rob),title('Robert');
Rob = Rob + pic2;
subplot(2,2,2);imshow(Rob),title('pic+Robert');

% Laplacian算子
Lap=zeros(h,w);  % 为保留图像的边缘一个像素
block=0;  % 4-邻域下的值
Flag=0.268;  % 阈值
for i=2:h-1
    for j=2:w-1
        block=abs(4*pic2(i,j)-pic2(i-1,j)-pic2(i+1,j)-pic2(i,j+1)-pic2(i,j-1));
        if(block > Flag)
            Lap(i,j)=1;
        else
            Lap(i,j)=0;
        end
    end
end
subplot(2,2,3);imshow(Lap),title('Laplacian');
Lap = Lap + pic2;
subplot(2,2,4);imshow(Lap),title('pic+Laplacian');
