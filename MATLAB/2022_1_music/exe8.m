clear;
load('Guitar.MAT');
%总共重复30次
wave2proc = [wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;...
    wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;...
    wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;wave2proc;...
    wave2proc;wave2proc;wave2proc;wave2proc;];%重复了30次

t = 0:1/8000:(length(wave2proc)-1)/8000;
Trg = [0;t(end)];
N = length(t);
OMGrg = [0;5000]*2*pi;
K = 20000;
[t,omg,FT,IFT] = prefourier(Trg,N,OMGrg,K);

y = FT*wave2proc;
y = [y(end:-1:2)/2;y(1);y(2:end)/2];
omg = [omg-omg(end);omg(2:end)];
plot(omg/2/pi,abs(y));
title('频域波形');
xlabel('频率(Hz)');
ylabel('强度');