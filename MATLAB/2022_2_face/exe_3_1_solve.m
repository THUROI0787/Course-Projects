%exe_3_1_solve
clear all;
close all;
clc;
%load('hall_pw.mat');
load('reproduct.mat');
%the length
leng_bin=[];
for a=1:8
    leng_bin=[leng_bin,char(mod(reproduct(a),2)+48)];  % char!!
end
leng=bin2dec(leng_bin);
%the password
password=[];
password_bin='00000000';
for a=1:leng
    for b=1:8
        password_bin(b)=mod(reproduct(8*a+b),2)+48;
    end
    password=[password,char(bin2dec(password_bin))];
end
password