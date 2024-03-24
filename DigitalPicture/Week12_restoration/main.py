# -*- coding: utf-8 -*-
import cv2
import numpy as np
from numpy import fft
import math
import os
import matplotlib.pyplot as plt

# 仿真运动模糊
def motion_process(image_size, motion_angle, k=1e-05):
    PSF = np.zeros(image_size)
    center_position = (image_size[0] - 1) / 2
    slope_tan = math.tan(motion_angle * math.pi / 180)
    slope_cot = 1 / slope_tan
    if slope_tan <= 1:
        for i in range(15):
            offset = round(i * slope_tan)  # ((center_position-i)*slope_tan)
            PSF[int(center_position + offset), int(center_position - offset)] = 1
    else:
        for i in range(15):
            offset = round(i * slope_cot)
            PSF[int(center_position - offset), int(center_position + offset)] = 1
    H = fft.fftshift(fft.fft2(PSF / PSF.sum())) + k
    return H

# 对图片进行运动模糊
def motion_blur(input, H, eps=0):
    input_fft = fft.fft2(fft.fftshift(input))  # 进行二维数组的傅里叶变换
    blur = fft.ifft2(fft.ifftshift(input_fft * H))
    blur = np.abs(blur)
    return blur


pic = cv2.imread("DIP.bmp",cv2.WINDOW_NORMAL)  # 读入灰度图
pic2 = pic.astype(float)/255
# pic_max = pic.max()
k_turbu = 0.001   # 0.00025 0.001 0.0025

kernel1 = np.zeros((7,7), float)
kernel2 = np.zeros((7,7), float)
kernel3 = np.array([[0, -1, 0],
                    [-1, 4, -1],
                    [0, -1, 0]])
for x in range(0, 7):
    for y in range(0, 7):
        kernel1[x,y] = math.exp(math.sqrt((x-3)*(x-3)+(y-3)*(y-3))/120)
        kernel2[x,y] = math.exp(-k_turbu*((x-3)*(x-3)+(y-3)*(y-3))**(5/6))
kernel1 = kernel1/sum(sum(kernel1))
kernel2 = kernel2/sum(sum(kernel2))
H = fft.fftshift(fft.fft2(kernel1, pic.shape))
H_turbu = fft.fftshift(fft.fft2(kernel2, pic.shape))
P = fft.fftshift(fft.fft2(kernel3, pic.shape))
c=1

def blur(pic, H):
    F = fft.fftshift(fft.fft2(pic))
    G = fft.ifft2(fft.ifftshift(H * F))
    output = np.abs(G)
    return output

def Gau(pic, sigma, mean=0):
    # sigma是方差
    h ,w = pic.shape
    gauss = np.random.normal(mean, math.sqrt(sigma), (h, w))
    pic2 = pic + gauss
    Sf = fft.fftshift(fft.fft2(pic))
    output = np.clip(pic2, a_min=0, a_max=1)  # 截断
    Sn = fft.fftshift(fft.fft2(output - pic))
    k = Sn/Sf
    return [output,k]


def inverse(pic, H, sigma, w0=40):
    h, w = pic.shape
    hc = int(h/2)
    wc = int(w/2)
    G = fft.fftshift(fft.fft2(pic))
    # H = H + sigma  # 还得优化
    M = 1/H
    if w0!=0:
        for x in range(0,h):
            for y in range(0,w):
                if ((x-hc)*(x-hc)+(y-wc)*(y-wc)) > w0*w0:
                    M[x,y] = M[int(hc+w0/2), int(wc+w0/2)]  # 取边界值当临界值
    F_hat = G * M
    output = np.abs(fft.ifftshift(fft.ifft2(F_hat)))
    output = output/output.max()
    return output

def wiener(pic, H, sigma, k, w0=0):
    h, w = pic.shape
    hc = int(h/2)
    wc = int(w/2)
    G = fft.fftshift(fft.fft2(pic))
    # H = H + sigma  # 还得优化
    M1 = np.conj(H) / (np.abs(H) ** 2)
    M = np.conj(H) / (np.abs(H) ** 2 + 0.3*k)
    if w0!=0:
        for x in range(0,h):
            for y in range(0,w):
                if ((x-hc)*(x-hc)+(y-wc)*(y-wc)) > w0*w0:
                    M[x,y]=M[int(hc+w0/2), int(wc+w0/2)]  # 取边界值当临界值
    F_hat = G * M
    output = np.abs(fft.ifftshift(fft.ifft2(F_hat)))
    output = output/output.max()    #  Normalization
    return output

def CLSF(pic, H, sigma,  w0=0):
    h, w = pic.shape
    hc = int(h/2)
    wc = int(w/2)
    G = fft.fftshift(fft.fft2(pic))
    # H = H + sigma  # 还得优化
    M1 = np.conj(H) / (np.abs(H) ** 2)
    M = np.conj(H) / (np.abs(H) ** 2 + 0.5 * (np.abs(P) ** 2))
    if w0!=0:
        for x in range(0,h):
            for y in range(0,w):
                if ((x-hc)*(x-hc)+(y-wc)*(y-wc)) > w0*w0:
                    M[x,y]=M[int(hc+w0/2), int(wc+w0/2)]  # 取边界值当临界值
    F_hat = G * M
    output = np.abs(fft.ifftshift(fft.ifft2(F_hat)))
    output = output/output.max()    #  Normalization
    return output

# pic_blur = cv2.filter2D(pic, -1, kernel)
sigma = 10/255
pic_blur = blur(pic2, H)
H_motion = motion_process(pic.shape, 60)
pic_blur2 = motion_blur(pic2, H_motion)
[pic_re, k] = Gau(pic_blur2, sigma)
# pic_inverse = inverse(pic_re, H, sigma)
# pic_wiener = wiener(pic_re, H, sigma, k)
pic_inverse = inverse(pic_re, H_motion, sigma)
pic_wiener = wiener(pic_re, H_motion, sigma, k)
pic_CLSF = CLSF(pic_re, H_motion, sigma)
cv2.imshow('original', pic2)
cv2.imshow('blur', pic_blur2)
cv2.imshow('Gau', pic_re)
cv2.imshow('inverse', pic_inverse)
cv2.imshow('wiener', pic_wiener)
cv2.imshow('CLSF', pic_CLSF)
# pic_inverse = inverse(pic_blur, filter, 0)
# cv2.imshow('inverse', pic_inverse)


cv2.waitKey(0)
cv2.destroyAllWindows()
