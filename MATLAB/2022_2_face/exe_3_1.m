%exe_3_1
clear all;
close all;
clc;
load ('hall.mat');
password='HYW is cute!!!';
leng=length(password);
leng_bin=dec2bin(leng,8); %dec2bin is char!
sample=hall_gray;
for a=1:8 %replace the last bit
    sample(a)=2*fix(sample(a)/2)+double(leng_bin(a)-48); %overflow?!
end
for a=1:leng
    password_bin=dec2bin(double(password(a)),8);
    for b=1:8
        sample(8*a+b)=2*fix(sample(8*a+b)/2)+double(password_bin(b)-48);
    end
end
hall_pw_gray=sample;
imwrite(uint8(sample),'exe_3_1.png','png');
save ('hall_pw.mat','hall_pw_gray');
imshow(uint8(hall_pw_gray));