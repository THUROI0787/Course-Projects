close all;clc;
load('train1');
%% 读取数据
%   r   =   H  *  w
% 从命令行读入a,b,c;
% 注意需要满足：a<=0,b>=0,c<=0,才能使三个解都>=0
n=19;  % 构造的H矩阵的维数
H=ones(1,n);
t1 = b/(a^2);
t2 = c/(a^3);
H(:,2:n) = [t1, t2, t1.^2, t2.^2, t1.^3, t2.^3, t1.^4, t2.^4, ...
    t1.*t2, (t1.^2).*t2, t1.*(t2.^2), (t1.*t2).^2, ...
    t2./t1, t1./t2, (t1.^2)./t2, (t2.^2)./t1, (t1./t2).^2, (t2./t1).^2];

%% 预测
r_hat = H*w

%% 真实结果
syms x;
eq = x^3+a*x^2+b*x+c==0; 
x_real=double(solve(eq,x));  % 得到三个解
p_real=x_real/sum(x_real);
r_real=-(sum(((log(p_real)/log(3)).*p_real)'))'
err_absolutely = abs(r_hat-r_real)
err_relatively = abs((r_hat-r_real)/r_real)