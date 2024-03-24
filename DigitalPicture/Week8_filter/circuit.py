# -*- coding: utf-8 -*-
import cv2
import numpy as np
import math
import os
from matplotlib import pyplot as plt

cv2.namedWindow("config", cv2.WINDOW_NORMAL)

# 创造数值滑动条
cv2.createTrackbar("kernel", "config", 0, 200, lambda x: None)
cv2.createTrackbar("butt_n", "config", 1, 40, lambda x: None)

#读取图像
img = cv2.imread('circuit.png', 0)
#傅里叶变换
f = np.fft.fft2(img)
#设置高通滤波器
rows, cols = img.shape
crow, ccol = int(rows/2), int(cols/2)

def IFFT(fshift):
    ishift = np.fft.ifftshift(fshift)
    iimg1 = np.fft.ifft2(ishift)
    iimg2 = np.abs(iimg1)
    iimg3 = iimg2.astype(np.uint8)
    return iimg3

while (1):

    k = cv2.waitKey(1)
    if k == ord('q'):
        break

    kernel = cv2.getTrackbarPos("kernel", "config")
    buttn = cv2.getTrackbarPos("butt_n", "config")
    fshift_ideal = np.fft.fftshift(f)
    fshift_butt = np.fft.fftshift(f)
    fshift_Gau = np.fft.fftshift(f)
    for h in range(0,rows):
        for w in range(0,cols):
            if (h-crow)*(h-crow)+(w-ccol)*(w-ccol) < kernel*kernel :
                fshift_ideal[h,w] = 0
            if kernel != 0:
                fshift_Gau[h,w] = fshift_Gau[h,w] * (1-math.exp(-((h-crow)*(h-crow)+(w-ccol)*(w-ccol))/(2*kernel*kernel)))
                if (h == crow) & (w == ccol):
                    fshift_butt[h, w] = 0
                else:
                    fshift_butt[h,w] = fshift_butt[h,w]/(1+((kernel*kernel)/((h-crow)*(h-crow)+(w-ccol)*(w-ccol)))**buttn)
    # 傅里叶逆变换
    img_ideal = IFFT(fshift_ideal)
    img_butt = IFFT(fshift_butt)
    img_Gau = IFFT(fshift_Gau)
    ideal1= img.astype('int')+img_ideal.astype('int')
    butt1=img.astype('int')+img_butt.astype('int')
    Gau1=img.astype('int')+img_Gau.astype('int')
    for h in range(0,rows):
        for w in range(0,cols):
            if ideal1[h,w]>=255:
                ideal1[h, w] = 255
            if butt1[h,w]>=255:
                butt1[h, w] = 255
            if Gau1[h,w]>=255:
                Gau1[h, w] = 255
    cv2.imshow('Original',img)
    cv2.imshow('Ideal', img_ideal)
    cv2.imshow('Butterworth', img_butt)
    cv2.imshow('Gaussian', img_Gau)
    cv2.imshow('Ideal_Sum', ideal1.astype('uint8'))
    cv2.imshow('Butterworth_Sum', butt1.astype('uint8'))
    cv2.imshow('Gaussian_Sum', Gau1.astype('uint8'))

cv2.waitKey(0)
cv2.destroyAllWindows()