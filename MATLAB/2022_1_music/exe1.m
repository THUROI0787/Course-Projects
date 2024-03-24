freq = [523.25,523.25,587.33,392,349.23,349.23,293.66,392];%输入频率
time = [1,0.5,0.5,2,1,0.5,0.5,2];%输入拍数
value = [];%建立用来存放音符的数组

for m = 1:length(freq)
    t = linspace(0,0.5*time(m),4000*time(m)).';
    value = [value;sin(2*pi*freq(m)*t)]; %用正弦信号采样
end

sound(value,8000);
%audiowrite('exe1.wav',value,8000); 
