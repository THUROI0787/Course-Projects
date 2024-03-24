figure(1);
load('Guitar.MAT');
plot(realwave,'k')
plot(wave2proc,'r');
temp = resample(realwave,10,1);%采样率提高至10倍
temp = reshape(temp,[length(temp)/10,10]);
for m = 1:10
    temp(:,m) = (sum(temp,2)/10);%求和取平均 //降噪
end
temp = reshape(temp,[1,numel(temp)]);
temp = resample(temp,1,10).';%恢复至原采样率
plot(temp,'b');
title('时域对比');
xlabel('t(s)');
ylabel('幅度');
legend('realwave','wave2proc','reproduct');

%% 作图对比
figure(2);
t = 0:1/8000:(length(realwave)-1)/8000;
Trg = [0;t(end)];
N = length(t);
OMGrg = [0;5000]*2*pi;
K = 20000;
[t,omg,FT,IFT] = prefourier(Trg,N,OMGrg,K);

subplot(3,2,1);
plot(t,realwave,'k');
title('realwave时域');
xlabel('t(s)');
ylabel('幅度');
subplot(3,2,2);
y1 = FT*realwave;
y1 = [y1(end:-1:2)/2;y1(1);y1(2:end)/2];
omg = [omg-omg(end);omg(2:end)];
plot(omg/2/pi,abs(y1),'k');
title('realwave频域');
xlabel('f(Hz)');
ylabel('强度');

subplot(3,2,3);
plot(t,wave2proc,'r');
title('wave2proc时域');
xlabel('t(s)');
ylabel('幅度');
subplot(3,2,4);
y2 = FT*wave2proc;
y2 = [y2(end:-1:2)/2;y2(1);y2(2:end)/2];
plot(omg/2/pi,abs(y2),'r');
title('wave2proc频域');
xlabel('f(Hz)');
ylabel('强度');

subplot(3,2,5);
plot(t,temp,'b');
title('reproduct时域');
xlabel('t(s)');
ylabel('幅度');
subplot(3,2,6);
y3 = FT*temp;
y3 = [y3(end:-1:2)/2;y3(1);y3(2:end)/2];
plot(omg/2/pi,abs(y3),'b');
title('reproduct频域');
xlabel('f(Hz)');
ylabel('强度');

