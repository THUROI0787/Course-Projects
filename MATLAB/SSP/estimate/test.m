close all;clear;clc;
load('train1');
%% 生成数据
%   r   =   H  *  w
% [m*1] = [m*n]*[n*1]
m=5000;  % 可理解为观测次数
n=19;  % 构造的H矩阵的维数
P=rand(m,3);
H=ones(m,n);
r=-(sum(((log(P)/log(3)).*P)'))';
t1 = P(:,1).*P(:,2) + P(:,1).*P(:,3) + P(:,2).*P(:,3);
t2 = P(:,1).*P(:,2).*P(:,3);
H(:,2:n) = [t1, t2, t1.^2, t2.^2, t1.^3, t2.^3, t1.^4, t2.^4, ...
    t1.*t2, (t1.^2).*t2, t1.*(t2.^2), (t1.*t2).^2, ...
    t2./t1, t1./t2, (t1.^2)./t2, (t2.^2)./t1, (t1./t2).^2, (t2./t1).^2];

%% 测试
r_hat = H*w;
err = abs((r_hat-r)./r);
err_max = max(err);         % 最大相对误差
err_mean = mean(err);       % 平均相对误差
MSE=sum((err).^2)./m;   % 均方误差