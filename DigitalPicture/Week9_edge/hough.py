import cv2 as cv
import skimage.filters as filt
import matplotlib.pyplot as plt
import numpy as np

button=2  # 1 2 3分别对应三种输入以及预先调好的阈值
cv.namedWindow('config', cv.WINDOW_AUTOSIZE)  # 建立空窗口

cv.createTrackbar('canny-low', 'config', 0, 255, lambda x: None)
cv.createTrackbar('canny-high', 'config', 0, 255, lambda x: None)
cv.createTrackbar('h-inster', 'config', 0, 100, lambda x: None)
cv.createTrackbar('h-comp', 'config', 0, 100, lambda x: None)
cv.createTrackbar('h-dist', 'config', 0, 100, lambda x: None)

def pictreshold(a):
    if a==1:
        pic = cv.imread("board-orig.bmp", 0)
    elif a==2:
        pic = cv.imread("board-Gauss-0.005.bmp", 0)
    elif a==3:
        pic = cv.imread("board-Gauss-0.01.bmp", 0)
    return pic

def canny(img,a,b):
    # Canny边缘检测
    result = cv.Canny(img, a, b)
    return result

def output_canny(pic,canl,canh):
    pic_canny = canny(pic,canl,canh)
    cv.imshow('canny_orig', pic_canny)
    return pic_canny

def output_line(pic,a,b,c):
    lines = cv.HoughLinesP(pic, 1, 1 * np.pi / 180, a, b, c)
    # 一条直线所需最少的曲线交点，组成一条直线的最少点的数量，被认为在一条直线上的亮点的最大距离
    # 画出检测的线段
    for line in lines:
        for x1, y1, x2, y2 in line:
            cv.line(pic, (x1, y1), (x2, y2), (255, 0, 0), 2)
        pass
    cv.imshow('canny_line', pic)

while (1):

    k = cv.waitKey(1)
    if k == ord('q'):
        break

    pic = pictreshold(button)
    canl=cv.getTrackbarPos('canny-low', 'config')
    canh=cv.getTrackbarPos('canny-high', 'config')
    threshold = cv.getTrackbarPos('h-inster', 'config')
    minLineLength = 2 * cv.getTrackbarPos('h-comp', 'config')
    maxLineGap = cv.getTrackbarPos('h-dist', 'config')

    pic1 = output_canny(pic, canl, canh)
    output_line(pic1,threshold,minLineLength,maxLineGap)


cv.waitKey(0)
cv.destroyAllWindows()
