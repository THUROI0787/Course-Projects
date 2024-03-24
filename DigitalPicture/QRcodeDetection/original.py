# -*- coding: utf-8 -*-
import cv2
import skimage.filters as filt
import numpy as np
import math
import os
from matplotlib import pyplot as plt

# 超参数调整
Gau_ksize = (11,11)  # 奇数
Gau_kernel = 70
aver_ksize = (11,11)
trih = 180
tril = 60
oc_kernel1 = 8
oc_kernel2 = 15
it1 = 3
it2 = 2

# cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
picsrc = cv2.imread("hard/6.jpg", cv2.IMREAD_GRAYSCALE)  # 读入灰度图
rows, cols = picsrc.shape
crow, ccol = int(rows/2), int(cols/2)

# def Gau(img):
#     f = np.fft.fft2(img)  # 傅里叶变换
#     fshift_Gau = np.fft.fftshift(f)
#     for h in range(0, rows):
#         for w in range(0, cols):
#             fshift_Gau[h, w] = fshift_Gau[h, w] * math.exp(
#                 -((h - crow) * (h - crow) + (w - ccol) * (w - ccol)) / (2 * Gau_kernel * Gau_kernel))
#     ishift = np.fft.ifftshift(fshift_Gau)  # 傅里叶逆变换
#     iimg1 = np.fft.ifft2(ishift)
#     iimg2 = np.abs(iimg1)
#     iimg3 = iimg2.astype(np.uint8)
#     return iimg3

def Open(img, a, it):  # 先腐蚀再膨胀，减少白点
    Morph_kernel = np.ones((a, a), np.uint8)
    pic_open = cv2.morphologyEx(img, cv2.MORPH_OPEN, Morph_kernel, iterations=it)
    return pic_open

def Close(img, a, it):  # 先膨胀再腐蚀，减少黑点
    Morph_kernel = np.ones((a, a), np.uint8)
    pic_close = cv2.morphologyEx(img, cv2.MORPH_CLOSE, Morph_kernel, iterations=it)
    return pic_close


# def BlackHat(img, a, it):  # 原图-闭运算，得到灰度较低的地方
#     Morph_kernel = np.ones((a, a), np.uint8)
#     pic_blackhat = cv2.morphologyEx(img, cv2.MORPH_BLACKHAT,  Morph_kernel, iterations=it)
#     return pic_blackhat

# def sobel(img):
#     # 计算Sobel卷积结果
#     x = cv2.Sobel(img, cv2.CV_16S, 1, 0)  # 运算时采用16位有符号整数
#     y = cv2.Sobel(img, cv2.CV_16S, 0, 1)
#
#     Scale_absX = cv2.convertScaleAbs(x)  # 作用：先截断255再取绝对值
#     Scale_absY = cv2.convertScaleAbs(y)
#     result = cv2.addWeighted(Scale_absX, 0.5, Scale_absY, 0.5, 0)  # 图像混合，和课件不同
#     return result

def trivalurize(M):
    return (M>=tril).astype(int)-(M<=trih).astype(int)  # 输出：-1 0 1 (int)


_,picsrcbina = cv2.threshold(picsrc, 0, 255, cv2.THRESH_OTSU)
# pic_Gau = cv2.GaussianBlur(picsrcbina,Gau_ksize,0,0)
# pic_Gau = Gau(picsrcbina)
pic_lp = cv2.blur(picsrcbina,aver_ksize)
# pic_Gau = Gau(picsrcbina)  # 得到边缘粗糙的灰度图，承接三值化操作
# pic_blackhat = BlackHat(pic_Gau, 7, 3)
# _,pic_Gau = cv2.threshold(picsrc, 127, 255, cv2.THRESH_BINARY)
pic_tri = trivalurize(pic_lp)
pic_white = 255*(pic_tri>=0).astype('uint8')
pic_black = 255*(pic_tri>0).astype('uint8')
pic_open = Open(pic_black, oc_kernel1, it1)
# for i in range(0,100):
#     pic_open = Open(pic_open)
pic_close = Close(pic_white, oc_kernel1, it1)
# for i in range(0,100):
#     pic_close = Close(pic_close, 5, 2)
pic_open_inv = cv2.bitwise_not(pic_open)  # 实现求反
pic_and = cv2.bitwise_and(pic_open_inv, pic_close)  # 初步的结果
# pic_and = Close(pic_and, 8, 1)
# _,picre = cv2.threshold(pic_sobel, 0, 255, cv2.THRESH_OTSU)
pic_small = Open(pic_and, oc_kernel2, it2)  # 去除不同区域的无关连接
pic_big = Close(pic_small, oc_kernel2, it2)  # 减少二维码中间黑点
cv2.namedWindow("output", cv2.WINDOW_NORMAL)
cv2.resizeWindow("output", 360, 480)
while True:
    cv2.imshow("output", pic_big)
    a = cv2.waitKey(0)
    if ord('q') == a:
        break
# cv2.imwrite("out3.jpg", pic_bina)
cv2.destroyAllWindows()