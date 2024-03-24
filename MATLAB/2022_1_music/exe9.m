clear;clc;
[y,fs] = audioread('fmt.wav');
M = 11910/14827*[0,1530,2570,3720,15050,21070,25800,29790,35610,40160,44890,48120,49890,57240,58380,59770,69720,77230,... %长余音未分出来
    78400,79170,80000,84480,88780,93940,98280,101030,103300,105360,107980,112640,116580,...
    122370,127040,132180,137270,141890,148270];
%% 确定基频与各次谐波分量
%z(:,1)存放基频大小；z(:,2),z(:,3)存放二次谐波的相对大小和值；在z(:,4),z(:,5)存放三次谐波的相对大小和值
z = zeros(length(M)-1,5);
amp = zeros(length(M)-1,1);
for m = 1:length(M)-1
    x = y(M(m)+1:M(m+1));
    amp(m) = max(x);%存放该音符的最大幅度值。
    x = [x;x;x;x;x];%重复5次，以进行频域分析。
    %进行傅里叶变换
    t = linspace(0,length(x)/8000,length(x));
    Trg = [0;t(end)];
    N = length(t);
    OMGrg = [0;2000]*2*pi;
    K = 2000;
    T = Trg(2)-Trg(1);
    t = linspace(Trg(1),Trg(2)-T/N,N)';
    OMG = OMGrg(2)-OMGrg(1);
    omg = linspace(OMGrg(1),OMGrg(2)-OMG/K,K)';
    IFT = OMG/2/pi/K*exp(j*kron(t,omg.'));
    X = T/N*exp(-j*kron(omg,t.'))*x;
 
    figure(2); %频域图像 ±2kHz
    subplot(6,7,m);
    Y = [X(end:-1:2)/2;X(1);X(2:end)/2];
    omg = [omg-omg(end);omg(2:end)];
    plot(omg/2/pi,abs(Y));
    %寻找基频
    [a,b] = max(abs(X));
    z(m,1) = b;
    e = a;
    %排除二次或三次谐波分量比基频强度还高的情况？？
    %计算二次谐波与三次谐波相对于基频的相对强度
    if(z(m,1)*2+20 > length(X))
        z(m,2) = 0;
        z(m,3) = 0;
    else
        c = X(z(m,1)*2-20:z(m,1)*2+20);
        [z(m,2),z(m,3)] = max(abs(c));
        z(m,2) = z(m,2)/e;
        z(m,3) = z(m,3)+z(m,1)*2-20;
    end
    if(z(m,1)*3+20 >length(X))
        z(m,4) = 0;
        z(m,5) = 0;
    else
        c = X(z(m,1)*3-20:z(m,1)*3+20);
        [z(m,4),z(m,5)] = max(abs(c));
        z(m,4) = z(m,4)/e;
        z(m,5) = z(m,5)+z(m,1)*3-20;
    end
end
%% 计算音符的持续拍数
len = []; 
for m = 1:length(z)
    len = [len;(M(m+1)-M(m)+1)/4000];
end
for m = 1:length(len)
    len(m) = round(len(m)*4)/4;
end
%% 定义合成音乐的参数
freq = z;%存放唱名的频率
save('freq.mat','freq');
time = len;%存放对应每一个唱名的持续拍数
sample = 4000;%采样率为8kHz，所以每拍（大概0.5s）是4000个采样点 
value = [];%存放最后的采样值
cover = 200;
%% 音乐合成
tail = zeros(cover,1);
[h,~] = size(freq); %??
for m = 1:h
    %创建一个时间采样序列,长度由唱名的持续拍数决定
    t = linspace(0,time(m)*0.5,sample*time(m)).';
    all = amp(m).*((sin(2*pi*freq(m,1)*t)+freq(m,2)*sin(2*pi*freq(m,3)*t)+...
        freq(m,4)*sin(2*pi*freq(m,5)*t)).*exp(-4*t));
    %下面尝试叠加
    head = all(1:cover);
    body = all(cover + 1:end - cover);
    head = head + tail;
    value = [value;head;body];
    tail = all(end-cover + 1:end);
end
value = [value;tail];
figure(1);
t = linspace(0,length(value)/8000,length(value));
plot(t,value);
sound(value,8000);