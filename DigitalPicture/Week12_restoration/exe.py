import cv2
import numpy as np
from numpy import fft
import math
import os
import matplotlib.pyplot as plt

pic = cv2.imread("DIP.bmp",cv2.WINDOW_NORMAL)  # 读入灰度图
pic2 = pic.astype(float)/255
# pic_max = pic.max()

kernel = np.zeros((7,7), float)
for x in range(0, 7):
    for y in range(0, 7):
        kernel[x,y] = math.exp(math.sqrt((x-3)*(x-3)+(y-3)*(y-3))/120)
kernel = kernel/sum(sum(kernel))
H = fft.fftshift(fft.fft2(kernel, pic2.shape))
# H_ = abs(H)

def blank(pic):
    F = fft.fftshift(fft.fft2(pic2))
    HF = H * F
    G = fft.ifft2(fft.ifftshift(HF))
    output = np.abs(G)
    # a = output.max()
    # output1 = output*pic_max/a
    # output2 = output.astype(float)
    G2 = fft.fftshift(fft.fft2(output))
    F2 = G2 / H
    F3 = HF / H   # 对照
    output3 = fft.ifft2(fft.ifftshift(F2))
    output4 = np.abs(output3)
    # b = output4.max()
    # output6 = output5.astype(float)
    return output4

cv2.imshow('blank', blank(pic))
cv2.imshow('pic', pic)
cv2.imshow('pic2', pic2)

cv2.waitKey(0)
cv2.destroyAllWindows()