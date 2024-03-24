close all; clear; clc;
pic=rgb2gray(imread('pic2.png'));  % ，经验证知R=G=B，故转换为单通道灰度图
pic2=double(pic)/255; %  以下皆用pic2来操作
[h,w]=size(pic2);

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
Flag=0.34;  % 阈值
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
