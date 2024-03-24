# -*- coding: utf-8 -*-
import cv2
import numpy as np
import math
import os
from matplotlib import pyplot as plt

cv2.namedWindow("config", cv2.WINDOW_NORMAL)

# 创造数值滑动条
cv2.createTrackbar("hp_kernel", "config", 0, 50, lambda x: None)
cv2.createTrackbar("kernel", "config", 0, 150, lambda x: None)
cv2.createTrackbar("butt_n", "config", 1, 30, lambda x: None)

#读取图像
img = cv2.imread('Lena.png', 0)
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

    hpk = cv2.getTrackbarPos("hp_kernel","config")
    kernel = cv2.getTrackbarPos("kernel", "config")
    buttn = cv2.getTrackbarPos("butt_n", "config")
    fshift_hp = np.fft.fftshift(f)
    fshift_lp = np.fft.fftshift(f)
    fshift_butt = np.fft.fftshift(f)
    fshift_Gau = np.fft.fftshift(f)
    for h in range(0,rows):
        for w in range(0,cols):
            if (h-crow)*(h-crow)+(w-ccol)*(w-ccol) < hpk*hpk :
                fshift_hp[h,w] = 0
            if (h - crow) * (h - crow) + (w - ccol) * (w - ccol) > kernel * kernel:
                fshift_lp[h, w] = 0
            if kernel != 0:
                fshift_Gau[h,w] = fshift_Gau[h,w] * math.exp(-((h-crow)*(h-crow)+(w-ccol)*(w-ccol))/(2*kernel*kernel))
            else:
                if (h==crow) & (w==ccol):
                    a=1
                else:
                    fshift_Gau[h, w]=0
            if kernel != 0:
                fshift_butt[h,w] = fshift_butt[h,w] / (1+(((h-crow)*(h-crow)+(w-ccol)*(w-ccol))/(kernel*kernel))**buttn)
            else:
                if (h == crow) & (w == ccol):
                    b=1
                else:
                    fshift_butt[h, w] = 0
    # 傅里叶逆变换
    img_hp = IFFT(fshift_hp)
    img_lp = IFFT(fshift_lp)
    img_butt = IFFT(fshift_butt)
    img_Gau = IFFT(fshift_Gau)
    # 显示原始图像和高通滤波处理图像
    # cv2.imshow('Original', img)
    cv2.imshow('Highpass', img_hp)
    cv2.imshow('Ideal', img_lp)
    cv2.imshow('Butterworth', img_butt)
    cv2.imshow('Gaussian', img_Gau)

cv2.waitKey(0)
cv2.destroyAllWindows()