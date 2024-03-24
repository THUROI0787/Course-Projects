%
clear all;
load('JpegCoeff.mat');
load('snow.mat');
% load('hall.mat');
% img = hall_gray;
%img = hall_gray-128;
%[len,width] = size(hall_gray);
% load('hall_pw.mat');
img = snow;
[len,width] = size(snow);
%QTAB = QTAB./2;
num = ceil(len/8)*ceil(width/8);
result = zeros(64,num);
for i = 1:ceil(len/8)
    for j=1:ceil(width/8)
        sample = img(i*8-7:i*8,j*8-7:j*8);
        dct_s = dct2(sample);
        qua = round(dct_s./QTAB);
        zigzag_res = zigzag(qua);
        result(:,j+(i-1)*ceil(width/8)) = zigzag_res;
    end
end