# -*- coding: utf-8 -*-
import cv2
import numpy as np
import math

pic1 = cv2.imread("pic2.png", cv2.IMREAD_GRAYSCALE)
pic2 = cv2.imread("pic3.png", cv2.IMREAD_GRAYSCALE)

def pce1(img):
    r = img.astype(float)
    g = img.astype(float)
    b = img.astype(float)
    zero = np.zeros((img.shape[0], img.shape[1]), dtype='uint8')
    img3 = np.zeros((img.shape[0], img.shape[1], 3), dtype='uint8')  # append
    for h in range(0,img.shape[0]):
        for w in range(0,img.shape[1]):
            if img[h,w] < 64:
                r[h,w] = 0
                g[h,w] = 255
                b[h,w] = img[h,w]*255/64
            elif (64 <= img[h,w]) & (img[h,w] <= 128):  # 检查g
                r[h,w] = 255/64 * img[h,w] - 255
                g[h,w] = 510 - 255/64 * img[h,w]
                b[h,w] = 255
            elif (128 < img[h, w]) & (img[h, w] < 192):
                r[h, w] = 255
                g[h, w] = 0
                b[h, w] = 255
            else:
                r[h, w] = 255
                g[h, w] = 0
                b[h, w] = -255/63*(img[h,w] - 255)
    R = cv2.convertScaleAbs(r)
    G = cv2.convertScaleAbs(g)
    B = cv2.convertScaleAbs(b)
    img3[:,:,0] = B  # B'G'R'
    img3[:,:,1] = G
    img3[:,:,2] = R
    return img3

def pce2(img,T,delta):
    r = img.astype(float)
    g = img.astype(float)
    b = img.astype(float)
    img1 = img.astype(float)
    zero = np.zeros((img.shape[0], img.shape[1]), dtype='uint8')
    img3 = np.zeros((img.shape[0], img.shape[1], 3), dtype='uint8')  # append
    for h in range(0,img.shape[0]):
        for w in range(0,img.shape[1]):
            r[h,w] = 255 * (1 + math.sin(2 * math.pi * img1[h,w] / T))
            g[h,w] = 255 * (1 + math.sin(2 * math.pi * (img1[h,w] - delta) / T))
            b[h,w] = 255 * (1 + math.sin(2 * math.pi * (img1[h,w] - 2 * delta) / T))
    R = cv2.convertScaleAbs(r)
    G = cv2.convertScaleAbs(g)
    B = cv2.convertScaleAbs(b)
    img3[:, :, 0] = B  # B'G'R'
    img3[:, :, 1] = G
    img3[:, :, 2] = R
    return img3

# pic1_pce1 = pce1(pic1)
# pic2_pce1 = pce1(pic2)
pic1_pce2 = pce2(pic1, 255, 255/6)
pic2_pce2 = pce2(pic2, 255, 255/6)
# cv2.imshow("pce2_1", pic1_pce2)
# cv2.imshow("pce2_2", pic2_pce2)
# cv2.imwrite("pic2_1_6.png", pic1_pce2)
# cv2.imwrite("pic3_1_6.png", pic2_pce2)
cv2.waitKey(0)
cv2.destroyAllWindows()


