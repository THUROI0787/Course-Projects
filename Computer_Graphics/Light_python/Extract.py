# -*- coding: utf-8 -*-
import cv2
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
# from scipy.special import sph_harm

# 球谐函数估计
def estimate_SH(image):
    # 计算图像的梯度
    gx = cv2.Sobel(image, cv2.CV_32F, 1, 0, ksize=1)
    gy = cv2.Sobel(image, cv2.CV_32F, 0, 1, ksize=1)
    grad = np.sqrt(gx**2 + gy**2)

    # 计算梯度方向
    theta = np.arctan2(gy, gx)

    # 计算球谐函数系数
    sh_coeffs = np.zeros((9, 9, 3))
    for c in range(3):
        for l in range(9):
            for m in range(-l, l+1):
                sh_coeffs[l, m, c] = np.sum(grad * sph_harm(m, l, theta, np.zeros_like(theta))) / np.sum(sph_harm(m, l, theta, np.zeros_like(theta))**2)

    # 计算光照
    lighting = np.zeros_like(image, dtype=np.float32)
    for c in range(3):
        for l in range(9):
            for m in range(-l, l+1):
                lighting[:, :, c] += sh_coeffs[l, m, c] * sph_harm(m, l, np.arccos(np.linspace(1, -1, image.shape[0])), np.linspace(0, 2*np.pi, image.shape[1]))

    return np.clip(lighting, 0, 255).astype(np.uint8)

# 环境光遮挡
def estimate_AO(image):
    # 计算图像的梯度和梯度方向
    gx = cv2.Sobel(image, cv2.CV_32F, 1, 0, ksize=1)
    gy = cv2.Sobel(image, cv2.CV_32F, 0, 1, ksize=1)
    grad = np.sqrt(gx**2 + gy**2)
    theta = np.arctan2(gy, gx)

    # 计算环境光遮挡
    ao_map = np.zeros_like(grad)
    for y in range(ao_map.shape[0]):
        for x in range(ao_map.shape[1]):
            for r in range(1, 5):
                for t in np.linspace(0, 2*np.pi, 16*r, endpoint=False):
                    dx = int(round(r * np.cos(t)))
                    dy = int(round(r * np.sin(t)))
                    if y+dy >= 0 and y+dy < ao_map.shape[0] and x+dx >= 0 and x+dx < ao_map.shape[1]:
                        ao_map[y, x] += grad[y+dy, x+dx] / (4*r)

    # 计算光照
    lighting = np.zeros_like(image, dtype=np.float32)
    for c in range(3):
        lighting[:, :, c] = np.median(image[:, :, c]) + ao_map * (np.max(image[:, :, c]) - np.median(image[:, :, c]))

    return np.clip(lighting, 0, 255).astype(np.uint8)


img = np.asarray(Image.open('test.png'))
img = cv2.imread('test.png')
# lighting_SH = estimate_SH(img)
lighting_AO = estimate_AO(img)
# print(lighting_SH)
print(lighting_AO)