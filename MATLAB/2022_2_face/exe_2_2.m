clear all;
close all;
clc;
load ('hall.mat');
sample=double(hall_gray(1:16,1:16));
sample=sample-ones(16,16)*128;
dct_sample=dct2(sample);
mydct_sample=mydct2(sample);
err=max(max(abs(mydct_sample-dct_sample)));