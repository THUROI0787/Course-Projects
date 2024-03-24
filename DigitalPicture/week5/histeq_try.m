function [pic_out]=histeq_try(pic_in,N2)
% 目前只能处理单通道
[h,w]=size(pic_in);
N1=20; N3=25;  %N2=256;
% N1是需要降低的峰值数目，是可以调的参数  % 能否引入峰值和边缘值的权重函数，从而不只是去除高峰？
num1=zeros(N2,1);
num2=zeros(N2,1);
peak=zeros(N1,1);
% 前提：对于这N1个峰值，都有其数目n满足：n/(h*w)>1/N2；
% 若考虑到floor()函数的截断，需要n/(h*w)>2/N2；

%% 原有直方图均衡化操作
for i=1:h  % 求pdf(个数)
   for j=1:w
       num1(pic_in(i,j)+1)= num1(pic_in(i,j)+1)+1;
    end
end

cdf=zeros(256);  % 求CDF并归一化
cdf(1)=num1(1);
for i=2:256
    cdf(i)=cdf(i-1)+num1(i);
end
cdf=floor(255*cdf/(h*w));  % 映射到[0,255]区间

pic_out=pic_in;
for i=1:h
   for j=1:w
       pic_out(i,j)= cdf(pic_in(i,j)+1);  % 原本该输出pic_out
    end
end

 %% 补充的优化操作
for i=1:h  % 求pic_out原本pdf(个数)
   for j=1:w
       num2(pic_out(i,j)+1)= num2(pic_out(i,j)+1)+1;
    end
end

[~,index]=sort(num2,'descend'); % 倒序排列
for i=1:N1
    peak(i)=index(i)-1;  % 从多到少，注意这里得-1
end

Border=zeros(h,w);  % 每个元素的border信息
for i=1:h
    for j=1:w
        Border(i,j)=border(pic_out,i,j);
    end
end
aver=mean(Border(:));  % 粗略判定是否是边界，如果大于平均值就是边界。

for i=1:h
   for j=1:w
       if ismember(pic_out(i,j),peak) && Border(i,j)>=aver/N3  % N3也是可以调整的参数
           pic_out(i,j)=pic_out(i,j)-1;
       end
    end
end