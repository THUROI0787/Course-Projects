clear; close all; clc;
pica=imread('A.jpg');
picb=imread('B.jpg');
pic=picb;

%% 关于直方图均衡化中RGB以及各种方法的尝试
% [h,w,~]=size(pic);
H=3;W=3;
pic_hist=histeq(pic);
[~,pic_hist_hand]=histeq_orig(pic);
[~,pic_hist_r]=histeq_rgb(pic,1);
[~,pic_hist_g]=histeq_rgb(pic,2);
[~,pic_hist_b]=histeq_rgb(pic,3);
[~,pic_hist_medi]=histeq_mode(pic,2);
[~,pic_hist_min]=histeq_mode(pic,1);
[~,pic_hist_max]=histeq_mode(pic,3);
pic_hist_rgb=pic;
pic_hist_rgb(:,:,1)=histeq(pic(:,:,1));
pic_hist_rgb(:,:,2)=histeq(pic(:,:,2));
pic_hist_rgb(:,:,3)=histeq(pic(:,:,3));

figure;
subplot(H,W,1);imshow(pic);title('Original');
subplot(H,W,2);imshow(pic_hist);title('Histeq');
% subplot(H,W,3);imshow(pic_hist_hand);title('Histeq-hand');
subplot(H,W,4);imshow(pic_hist_medi);title('Histeq-hand-medi');
subplot(H,W,5);imshow(pic_hist_min);title('Histeq-hand-min');
subplot(H,W,6);imshow(pic_hist_max);title('Histeq-hand-max');
subplot(H,W,7);imshow(pic_hist_r);title('Histeq-hand-r');
subplot(H,W,8);imshow(pic_hist_g);title('Histeq-hand-g');
subplot(H,W,9);imshow(pic_hist_b);title('Histeq-hand-b');
subplot(H,W,3);imshow(pic_hist_rgb);title('Histeq-rgb');

figure;
subplot(H,W,1);imhist(pic);title('Original');
subplot(H,W,2);imhist(pic_hist);title('Histeq');
% subplot(H,W,3);imshow(pic_hist_hand);title('Histeq-hand');
subplot(H,W,4);imhist(pic_hist_medi);title('Histeq-hand-medi');
subplot(H,W,5);imhist(pic_hist_min);title('Histeq-hand-min');
subplot(H,W,6);imhist(pic_hist_max);title('Histeq-hand-max');
subplot(H,W,7);imhist(pic_hist_r);title('Histeq-hand-r');
subplot(H,W,8);imhist(pic_hist_g);title('Histeq-hand-g');
subplot(H,W,9);imhist(pic_hist_b);title('Histeq-hand-b');
subplot(H,W,3);imhist(pic_hist_rgb);title('Histeq-rgb');

% imwrite(pic,'picA_original.jpg')
% imwrite(pic_hist,'picA_Histeq.jpg')
% imwrite(pic_hist_rgb,'picA_Histeq-rgb.jpg')

%% 作业直方图规定化
H1=2;W1=2;
H2=8;W2=2;
hisa=imhist(pica);
hisb=imhist(picb);

% histeq
pica_ = histeq(pica, hisb);
picb_ = histeq(picb, hisa);
% imwrite(pica_,"A_RU.jpg");
% imwrite(picb_,"B_RU.jpg");
figure;
subplot(H1,W1,1);imshow(pica);title('A');
subplot(H1,W1,2);imshow(picb);title('B');
subplot(H1,W1,3);imshow(pica_);title('A*');
subplot(H1,W1,4);imshow(picb_);title('B*');
figure;
subplot(H2,W2,1);imhist(pica);title('A');
subplot(H2,W2,3);imhist(pica(:,:,1));title('A-r');
subplot(H2,W2,5);imhist(pica(:,:,2));title('A-g');
subplot(H2,W2,7);imhist(pica(:,:,3));title('A-b');
subplot(H2,W2,2);imhist(picb);title('B');
subplot(H2,W2,4);imhist(picb(:,:,1));title('B-r');
subplot(H2,W2,6);imhist(picb(:,:,2));title('B-g');
subplot(H2,W2,8);imhist(picb(:,:,3));title('B-b');
subplot(H2,W2,9);imhist(pica_);title('A*');
subplot(H2,W2,11);imhist(pica_(:,:,1));title('A*-r');
subplot(H2,W2,13);imhist(pica_(:,:,2));title('A*-g');
subplot(H2,W2,15);imhist(pica_(:,:,3));title('A*-b');
subplot(H2,W2,10);imhist(picb_);title('B*');
subplot(H2,W2,12);imhist(picb_(:,:,1));title('B*-r');
subplot(H2,W2,14);imhist(picb_(:,:,2));title('B*-g');
subplot(H2,W2,16);imhist(picb_(:,:,3));title('B*-b');
% imwrite(pic_sin,"pic_sin.png");