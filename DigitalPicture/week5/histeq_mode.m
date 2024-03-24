function [num,pic_out]=histeq_mode(pic_in,n)
[h,w,~]=size(pic_in);
num=zeros(1,256);
pic_mode=pic_in(:,:,1);

for i=1:h  % 求pdf(个数)
   for j=1:w
       exp=zeros(3,1,'uint8');
       exp(1,1)=pic_in(i,j,1);
       exp(2,1)=pic_in(i,j,2);
       exp(3,1)=pic_in(i,j,3);
       if n==2
           pic_mode(i,j)= median(exp);
       elseif n==1
           pic_mode(i,j)= min(exp);
       elseif n==3
           pic_mode(i,j)= max(exp);
       end
       num(pic_mode(i,j)+1)= num(pic_mode(i,j)+1)+1;
    end
end

cdf=zeros(1,256);  % 求CDF并归一化
cdf(1)=num(1);
for i=2:256
    cdf(i)=cdf(i-1)+num(i);
end
cdf=floor(255*cdf/(h*w));  % 映射到[0,255]区间

pic_out=pic_in;
for i=1:h
   for j=1:3*w
       pic_out(i,j)= cdf(pic_in(i,j)+1);
    end
end