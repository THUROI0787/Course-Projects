clear all;
close all;
clc;

a=[1];
b=[0.1,-0.2,1.2,-0.2,0.1];
figure,[h,~]=impz(b,a,21);
stem([0:20],h);
