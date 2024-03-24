close all; clc;clear;
% image:0-2.2e+05
load("work2.mat");
c=[1,5,10,50,100];
ima=abs(image);  % 求模长
a=max(max(ima));  % 求最大值
ima0=ima*255/a;  % 映射到[0,255]区间
figure;
subplot(2,3,1);imshow(ima0);title("Original");  
% imwrite(ima0,"work2_0.png");
for i=1:5
   ima0_log=c(i)*log(ima0+1); 
   subplot(2,3,i+1);imshow(ima0_log);title("c="+c(i));  
   % imwrite(ima0_log,"work2_c="+c(i)+".png");
end