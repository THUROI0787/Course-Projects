function [num,pic_out]=histeq_rgb(pic_in,n)
[h,w]=size(pic_in);
num=zeros(1,256);
pic_exp=pic_in(:,:,1);

for i=1:h  % 求pdf(个数)
   for j=1:w/3
       pic_exp(i,j)= pic_in(i,j,n);
       num(pic_exp(i,j)+1)= num(pic_exp(i,j)+1)+1;
    end
end

cdf=zeros(1,256);  % 求CDF并归一化
cdf(1)=num(1);
for i=2:256
    cdf(i)=cdf(i-1)+num(i);
end
cdf=floor(255*cdf/(h*w/3));  % 映射到[0,255]区间

pic_out=pic_in;
for i=1:h
   for j=1:w
       pic_out(i,j)= cdf(pic_in(i,j)+1);
    end
end