clear;clc;
%% 定义参数
freq = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];%存放唱名的频率
time = [1,0.5,0.5,2,1,0.5,0.5,2];%存放对应每一个唱名的持续拍数
beat = 0.5;%一拍的持续时间
sample = 4000;%采样率为8kHz，所以每拍（大概0.5s）是4000个采样点
value = [];%存放最后的采样值
total = sum(sample*time);
total_time = linspace(0,sum(time)*0.5,sample*length(time)).';
cover = 200;

%% 音乐合成
tail = zeros(cover,1);
for m = 1:length(freq)
    %创建一个时间采样序列,长度由唱名的持续拍数决定
    t = linspace(0,time(m)*0.5,sample*time(m)).';
    all = (sin(2*pi*freq(m)*t)+0.2*sin(2*pi*2*freq(m)*t)+0.3*sin(2*pi*3*freq(m)*t)).*shape_linear(t*6/t(end));
    %下面尝试叠加
    head = all(1:cover);
    body = all(cover + 1:end - cover);
    head = head + tail;
    value = [value;head;body];
    tail = all(end-cover + 1:end);
end
value = [value;tail];
%% 音乐播放、保存、波形显示
sound(value,8000);
%audiowrite('(4).wav',value,8000);%保存

%%
%画出时域波形与频域波形
figure;
subplot(1,2,1);
totalbeat = sum(time)-(length(time)-1)*cover/sample;
t = linspace(0,totalbeat*beat,totalbeat*sample);
plot(t,value);
title('时域波形');
xlabel('t(s)');
ylabel('幅度');

subplot(1,2,2);
Trg = [0;totalbeat*beat];
N = totalbeat*sample;
OMGrg = [0;2000]*2*pi;
K = 2000;
[t,omg,FT,IFT] = prefourier(Trg,N,OMGrg,K);
y = FT*value;
y = [y(end:-1:2)/2;y(1);y(2:end)/2];
omg = [omg-omg(end);omg(2:end)];
plot(omg/2/pi,abs(y));
title('频域波形');
xlabel('f(Hz)');
ylabel('强度');
