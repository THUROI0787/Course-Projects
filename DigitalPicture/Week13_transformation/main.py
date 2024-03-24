# -*- coding: utf-8 -*-
import cv2
import numpy as np
from numpy import fft
import math
import os
import matplotlib.pyplot as plt

pic = cv2.imread("Lena.bmp",cv2.WINDOW_NORMAL)  # 读入灰度图
pic = pic.astype(float)/255
row, col = pic.shape  # (256, 256)


# 仿射变换
M_translantion = np.float32([[1, 0, -80], [0, 1, -80]])  # 平移
M_scale = np.float32([[7, 0, 0], [0, 7, 0]])  # 缩放
# M_scale = np.float32([[0.4, 0, 0], [0, 0.4, 0]])
M_rotate = cv2.getRotationMatrix2D((0, 0), 30, 1)  # 旋转
M_shear = np.float32([[1,-0.5,0],[0,1,0]])  # 错切
M_reflect = np.float32([[-1,0,row],[0,1,0]])  # 反射

pic_translation1 = cv2.warpAffine(pic, M_translantion, (col, row))
pic_translation2 = cv2.warpAffine(pic, M_translantion, (col-80, row-80))

pic_scale = cv2.warpAffine(pic, M_translantion, (col-80, row-80))
pic_scale_LINEAR = cv2.warpAffine(pic_scale, M_scale, (2*col, 2*row), flags=cv2.INTER_LINEAR)
pic_scale_NEAREST = cv2.warpAffine(pic_scale, M_scale, (2*col, 2*row), flags=cv2.INTER_NEAREST)
pic_scale_AREA = cv2.warpAffine(pic_scale, M_scale, (2*col, 2*row), flags=cv2.INTER_AREA)
pic_scale_CUBIC = cv2.warpAffine(pic_scale, M_scale, (2*col, 2*row), flags=cv2.INTER_CUBIC)

# pic_scale = pic
# pic_scale_LINEAR = cv2.warpAffine(pic_scale, M_scale, (int(0.4*col), int(0.4*row)), flags=cv2.INTER_LINEAR)
# pic_scale_NEAREST = cv2.warpAffine(pic_scale, M_scale, (int(0.4*col), int(0.4*row)), flags=cv2.INTER_NEAREST)
# pic_scale_AREA = cv2.warpAffine(pic_scale, M_scale, (int(0.4*col), int(0.4*row)), flags=cv2.INTER_AREA)
# pic_scale_CUBIC = cv2.warpAffine(pic_scale, M_scale, (int(0.4*col), int(0.4*row)), flags=cv2.INTER_CUBIC)
# pic_reflect = cv2.warpAffine(pic, M_reflect, (col, row))

pic_rotate_LINEAR = cv2.warpAffine(pic, M_rotate, (col, row), flags=cv2.INTER_LINEAR)
pic_rotate_NEAREST = cv2.warpAffine(pic, M_rotate, (col, row), flags=cv2.INTER_NEAREST)
pic_rotate_AREA = cv2.warpAffine(pic, M_rotate, (col, row), flags=cv2.INTER_AREA)
pic_rotate_CUBIC = cv2.warpAffine(pic, M_rotate, (col, row), flags=cv2.INTER_CUBIC)
pic_shear = cv2.warpAffine(pic, M_shear, (col, row))
pic_reflect = cv2.warpAffine(pic, M_reflect, (col, row))

cv2.imshow('original', pic)
cv2.imshow('translation1', pic_translation1)
cv2.imshow('translation2', pic_translation2)
cv2.imshow('scale_Linear', pic_scale_LINEAR)
cv2.imshow('scale_Nearest', pic_scale_NEAREST)
cv2.imshow('scale_Area', pic_scale_AREA)
cv2.imshow('scale_Cubic', pic_scale_CUBIC)
cv2.imshow('rotate_Linear', pic_rotate_LINEAR)
cv2.imshow('rotate_Nearest', pic_rotate_NEAREST)
cv2.imshow('rotate_Area', pic_rotate_AREA)
cv2.imshow('rotate_Cubic', pic_rotate_CUBIC)
cv2.imshow('shear', pic_shear)
cv2.imshow('reflect', pic_reflect)



# 透视变换

# 通过坐标直接得到变换矩阵，可以更方便地迁移
# 原图像中的三组坐标
pts1 = np.float32([[0, 0], [col, 0], [0, row]])
# 转换后的三组对应坐标
pts2 = np.float32([[0, 0], [col, 0], [0, row-100]])
# 计算仿射变换矩阵
M2 = cv2.getAffineTransform(pts1, pts2)
# 执行变换
pic_trans = cv2.warpAffine(pic, M2, (row, col-100))

# 透视变换，也是通过迁移的方法来实现
# 原图的四组顶点坐标
pts3D1 = np.float32([[0, 0], [col, 0], [0, row], [col, row]])
# 转换后的四组坐标
pts3D2 = np.float32([[50, 50], [col-50, 50], [0, row], [col, row]])
# 计算透视变换矩阵
M = cv2.getPerspectiveTransform(pts3D1, pts3D2)
# 执行变换
pic_3Dtrans = cv2.warpPerspective(pic, M, (row, col))


cv2.imshow("transform", pic_trans)
cv2.imshow("transform3D", pic_3Dtrans)
# cv2.imwrite("transform.jpg", pic_trans)
# cv2.imwrite("transform3D.jpg", pic_3Dtrans)


# 重映射
mapx = np.zeros([row,col], dtype=np.float32)
mapy = np.zeros([row,col], dtype=np.float32)
mapx1 = np.zeros([row,col], dtype=np.float32)
mapy1 = np.zeros([row,col], dtype=np.float32)
for i in range(row):
    for j in range(col):
        mapy[i, j] = i
        mapy1[i, j] = i
        if i <= 195:
            mapx1[i, j] =  65 + j/2
            if j <=40:
                mapx[i, j] = 0
            else:
                mapx[i, j] = j - 40
        else:
            mapx1[i, j] = j
            if j >= col-40:
                mapx[i, j] = col-1
            else:
                mapx[i, j] = j + 40

pic_remap = cv2.remap(pic, mapx, mapy, cv2.INTER_NEAREST)
pic_remap1 = cv2.remap(pic, mapx1, mapy1, cv2.INTER_CUBIC)
cv2.imshow("remap", pic_remap)
cv2.imshow("remap1", pic_remap1)
# cv2.imwrite("remap.jpg", pic_remap)
# cv2.imwrite("remap1.jpg", pic_remap1)




cv2.waitKey(0)
cv2.destroyAllWindows()
