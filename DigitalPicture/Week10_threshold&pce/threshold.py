# -*- coding: utf-8 -*-
import cv2
import numpy as np
import math

def iter(img):
    aver = img.mean()
    while True:
        # 获取灰度图背景平均值
        aver0 = img[img < aver].mean()
        # 获取灰度图前景平均值
        aver1 = img[img >= aver].mean()
        # 计算新的阈值
        aver_new = (aver0 + aver1) / 2
        # 判断是否终止
        if abs(aver_new - aver) < 0.05:  # 对比50
            break
        else:
            aver = aver_new
    aver = int(aver)
    # 根据最佳阈值进行图像分割
    _, img_re = cv2.threshold(img, aver, 255, cv2.THRESH_BINARY)
    # 显示图像
    result = [aver, img_re]
    return result

pic = cv2.imread("pic1.png", cv2.IMREAD_GRAYSCALE)  # 读入灰度图
otsu_thre, pic_otsu = cv2.threshold(pic, 0, 255, cv2.THRESH_OTSU)
pic_adap = cv2.adaptiveThreshold(pic, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 51, 40)
# 参数为MEAN或GAUSSIAN
iter_thre, pic_iter = iter(pic)  # aver=135
thres2 = 190  # 可调参数
_, pic_iter2 = cv2.threshold(pic, thres2, 255, cv2.THRESH_TRUNC)
pic_iter2[pic_iter2 == thres2] = 255

cv2.imshow("OTSU", pic_otsu)
cv2.imshow("iteration", pic_iter)
cv2.imshow("iteration2", pic_iter2)
cv2.imshow("adaptive", pic_adap)
# cv2.imwrite("OTSU_orig.png", pic_otsu)
# cv2.imwrite("iter_orig.png", pic_iter)
# cv2.imwrite("iter2.png", pic_iter2)
cv2.waitKey(0)
cv2.destroyAllWindows()