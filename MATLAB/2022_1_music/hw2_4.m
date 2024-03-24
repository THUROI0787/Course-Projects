clear;
clc;
%划分音符区间
[y,fs] = audioread('fmt.wav');
P = [0,2174,14205,17963,21713,25217,28903,32402,...
    36286,40244,46146,56114,62353,67932,71703,75692,...
    78916,82808,84703,86595,90367,93893,98325,101977,...
    106121,110020,114568,119609,131072];
b = zeros(length(P)-1,5);
amp = zeros(length(P)-1,5);
%先看看每个音符大概长啥样
for p = 2:length(P)
    x = y(P(p-1)+1:P(p));   %每个音符的采样区间,数组索引必须为正整数
    x = [x;x;x;x;x];    %重复多次便于频域分析
    %傅里叶变换
    T = length(x)/fs;
    N = length(x);
    t = linspace(-T/2,T/2-T/N,N)';
    OMG = 5000*2*pi;
    K = 2000;
    omg = linspace(-OMG/2,OMG/2-OMG/K,K)';
    F = 0*omg;
    U = exp(-j*kron(omg,t.'));
    F = T/N*U*x;
    %%figure(2);
    %subplot(5,6,p-1);
    %plot(omg/2/pi,abs(F));
    %基频
    [a,fx] = max(abs(F));
    b(p-1,1) = fx;
    amp(p-1,1) = a;
    a1 = max(abs(F(round(fx/2)-10):(round(fx/2)+10)));  %只能返回最大值而不能返回对应频率？？
    if 2*a1>=abs(a)
        b(p-1,1) = fx/2;
        amp(p-1,1) = a1;
    end
    a1 = max(abs(F(round(fx/3)-10):(round(fx/3)+10)));
    if 2*a1>=abs(a)
        b(p-1,1) = fx/3;
        amp(p-1,1) = a1;
    end
    %谐波相对基频的强度
    if(b(p-1,1)*2+20)>length(F)
        b(p-1,2:5) = 0;
    else 
        amp(p-1,2)= max(abs(F(round(b(p-1,1)*2-20):round(b(p-1,1)*2+20))));
        b(p-1,2) = b(p-1,1)*2;
    end
    if(b(p-1,1)*3+20)>length(F)
        b(p-1,3:5) = 0;
    else 
        amp(p-1,3) = max(abs(F(round(b(p-1,1)*3-20):round(b(p-1,1)*3+20))));
        b(p-1,3) = b(p-1,1)*3;
    end
    if(b(p-1,1)*4+20)>length(F)
        b(p-1,4:5) = 0;
    else 
        amp(p-1,4) = max(abs(F(round(b(p-1,1)*4-20):round(b(p-1,1)*4+20))));
        b(p-1,4) = b(p-1,1)*4;
    end
    if(b(p-1,1)*7+20)>length(F)
        b(p-1,5) = 0;
    else 
        amp(p-1,5) = max(abs(F(round(b(p-1,1)*7-20):round(b(p-1,1)*7+20))));
        b(p-1,5) = b(p-1,1)*7;
    end
end
tune = (P(2)-P(1)+1)/4000;
for m=2:length(b)
    tune = [tune;(P(m+1)-P(m)+1)/4000];
end
fs = 8000;
u = 100;
tail = zeros(1,u);
g = [];
for m = 1:length(b)
    T = linspace(0,tune(m)*0.5,fs*tune(m)*0.5)
    my = (amp(m,1)*sin(2*pi*b(m,1)*T)+amp(m,2)*sin(2*pi*b(m,2)*T)+amp(m,3)*sin(2*pi*b(m,3)*T)+amp(m,4)*sin(2*pi*b(m,4)*T)+amp(m,5)*sin(2*pi*b(m,5)*T)).*bask_exp(T/t(m)*0.5);
    head = my(1:u);
    body = my(u+1:length(my)-u);
    head = head+tail;
    z = [head,body];
    g = [g,z];
    tail = my(length(my)-u+1:length(my));
end
g = [g,tail];
time = linspace(0,length(g)/8000,length(g));
plot(time,g);
%sound(g,fs);
%audiowrite('1_4exp.wav',x,8000);

function a = bask_exp(t)
a =exp(-10*t);
end

function a = bask_line(t)
a = zeros(1,length(t));
for n = 1:length(t)
    if(t(n)>=0 & t(n)<1/6)
        a(n) = 8*t(n);
    elseif(t(n)>=1/6 & t(n)<1/3)
        a(n) = 5/3-2*t(n);
    elseif(t(n)>=1/3 & t(n)<2/3)
        a(n) = 1;
    elseif(t(n)>=2/3 & t(n)<1)
        a(n) = -3*t(n)+3;
    else a(n) = 0; 
end    
end
end