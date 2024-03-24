# -*- coding: utf-8 -*-
import cv2
import numpy as np

# for i in range(1, 7):
#     image_path = f"hard/{i}.jpg"

# 定义参数
image_path = 'add/10.jpeg'  # 待检测的图片路径
blur_kernel_size = (11, 11)  # 高斯滤波器
blackhat_kernel_size = (60, 60)  # 底帽滤波器
threshold_ratio = 0.7  # 二值化阈值（比例）
max_distance = 9  # 二维码掩膜边界宽度
mask_open_kernel_size = (13, 13)  # 膨胀和腐蚀操作的核的大小
min_contour_area_ratio = 0.7  # 去掉面积较小的目标区域的阈值（比例）
contour_line = 7  # 绘制方框线粗细

# 读入待检测的图片
img = cv2.imread(image_path)
h0, w0 = img.shape[:2]
# 通过分辨率近似处理较为极端的情况
if h0 * w0 / 10000 >= 1100:  # 二维码较大
    max_distance = 40
    blackhat_kernel_size = (110, 110)
    contour_line = 13
elif h0 * w0 / 10000 <= 250:  # 二维码很小
    max_distance = 7
    contour_line = 5

flag = 0

def preprocessing(img, treshold_flag):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # 转灰度图
    gray = cv2.GaussianBlur(gray, blur_kernel_size, 0)  # 高斯滤波
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, blackhat_kernel_size)  # 底帽滤波
    cap = cv2.morphologyEx(gray, cv2.MORPH_BLACKHAT, kernel)

    if treshold_flag == 0:  # 二值化操作
        _, thresh = cv2.threshold(cap, int(np.max(cap) * threshold_ratio), 255, cv2.THRESH_BINARY)
    else:  # flag = 1 0r 2
        _, thresh = cv2.threshold(cap, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    return thresh

def position(thresh):
    thresh = cv2.bitwise_not(thresh)
    dist_transform = cv2.distanceTransform(thresh, cv2.DIST_L2, 5)  # 计算距离
    dist_transform = cv2.convertScaleAbs(dist_transform)
    mask = np.zeros_like(thresh)  # 过滤出二维码部分的掩膜
    mask[dist_transform < max_distance] = 255

    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, mask_open_kernel_size)
    mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel)  # 开运算
    mask = cv2.convertScaleAbs(mask)

    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    max_area = 0
    for contour in contours:
        area = cv2.contourArea(contour)
        if area > max_area:
            max_area = area
    threshold_area = max_area * min_contour_area_ratio
    for contour in contours:
        if cv2.contourArea(contour) < threshold_area:  # 将太小的区域填充擦除
            mask = cv2.drawContours(mask, [contour], -1, 0, -1)
    return mask

def draw(mask, flag):

    if flag == 2:  # 寻找轮廓
        contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    else:
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    for contour in contours:  # 对每个轮廓绘制边框
        rect = cv2.minAreaRect(contour)  # 计算最小外接矩形
        box = cv2.boxPoints(rect)
        box = np.int0(box)
        d1 = np.linalg.norm(box[0] - box[2])
        d2 = np.linalg.norm(box[1] - box[3])

        _, (w, h), angle = rect  # 判断是否接近正方形
        a = w / h
        b = d1 / d2
        if flag == 0:
            if 10000 * (w * h) / (w0 * h0) <= 20:  # 区域实在太小，有可能是对比度的问题
                flag = 1
            elif (w / h > 0.5) & (w / h < 1.7) & (d1 / d2 > 0.8) & (d1 / d2 < 1.2) & ((angle < 20) | (angle > 70)):
                # 绘制矩形
                cv2.drawContours(img, [box], 0, (0, 255, 0), contour_line)
                flag = 0
                break
            else:
                flag = 1
        elif flag == 1:
            if (w * h) / (w0 * h0) >= 0.7:  # 区域很大，有可能是高信息量的问题
                flag = 2
            elif (w / h > 0.5) & (w / h < 1.7) & (d1 / d2 > 0.8) & (d1 / d2 < 1.2):
                cv2.drawContours(img, [box], 0, (0, 255, 0), contour_line)  # 绘制矩形
                flag = 0
                break
        elif flag == 2:
            if (w / h > 0.95) & (w / h < 1.05) & (d1 / d2 > 0.95) & (d1 / d2 < 1.05) & (
                    (angle < 10) | (angle > 80)):
                cv2.drawContours(img, [box], 0, (0, 255, 0), contour_line)
                flag = 0
                break
    return img, flag


thresh = preprocessing(img, flag)
mask = position(thresh)
result, flag = draw(mask, flag)

if flag == 1:  # 后验修改，处理颜色区分度不高的图像
    if h0 * w0 / 10000 <= 400:  # 处理较为极端的情况
        blur_kernel_size = (1, 1)
        blackhat_kernel_size = (10, 10)
        max_distance = 9
        blackhat_kernel_size = (110, 110)
    else:
        max_distance = 3
    thresh = preprocessing(img, flag)
    mask = position(thresh)
    result, flag = draw(mask, flag)

if flag == 2:  # 后验修改，处理高信息量的图像
    if h0 * w0 / 10000 <= 400:  # 处理较为极端的情况
        blur_kernel_size = (1, 1)
        blackhat_kernel_size = (10, 10)
        max_distance = 9
        blackhat_kernel_size = (110, 110)
    thresh = preprocessing(img, flag)
    mask = position(thresh)
    result, flag = draw(mask, flag)

if flag == 0:
    cv2.imshow('result', cv2.resize(result, (360, 480)))
    # cv2.imwrite(f"10.jpg", result)
else:
    print("Unable to recognize a valid QR code!")

cv2.waitKey(0)
cv2.destroyAllWindows()
