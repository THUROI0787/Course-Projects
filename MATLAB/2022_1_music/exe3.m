freq = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];%输入频率
time = [1,0.5,0.5,2,1,0.5,0.5,2];%输入拍数
value = [];%建立用来存放音符的数组
cover = 150;%覆盖的点数，参考后选择150

tail = zeros(cover,1); %初始化为0，便于下面head+tail运算
for m = 1:length(freq)
    %创建一个时间采样序列,长度由唱名的持续拍数决定
    t = linspace(0,0.5*time(m),4000*time(m)).';
    note = sin(2*pi*freq(m)*t).*exp(-4*t/t(end));%对每个音符用指数包络
    %进行叠加
    head = note(1:cover);
    body = note(cover + 1:end - cover);
    head = head + tail; %此时tail还未被换值
    value = [value;head;body];
    tail = note(end-cover + 1:end);
end
value = [value;tail]; %补上最后一个tail

%% 直接升高一个八度（允许时间改变）
%sound(value,16000);%升高一个八度
%audiowrite('exe3_1.wav',value,16000);

%% 直接降低一个八度（允许时间改变）
%sound(value,4000);%降低一个八度
%audiowrite('exe3_2.wav',value,4000);

%% 使用resample函数升高半个音阶
%value = resample(value,10000,10595);
%sound(value,8000);
%audiowrite('exe3_3.wav',value,8000);
