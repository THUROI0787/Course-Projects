%
load ('hall.mat');
sample=double(hall_gray(1:16,1:16));
ans1=sample-ones(16,16)*128;
dct_sample=dct2(sample);
dct_128=dct2(ones(16,16)*128);
dct_sample(1,1)=dct_sample(1,1)-dct_128(1,1);
ans2=idct2(dct_sample);
err=max(max(abs(ans1-ans2)))