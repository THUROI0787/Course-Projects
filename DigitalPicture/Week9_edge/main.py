import cv2 as cv
import skimage.filters as filt

button=3  # 1 2 3分别对应三种输入以及预先调好的阈值

def pictreshold(a):
    if a==1:
        pic = cv.imread("board-orig.bmp", 0)
        result=[pic,50,127,85,30,160]
    elif a==2:
        pic = cv.imread("board-Gauss-0.005.bmp", 0)
        result = [pic, 60, 150, 160, 255, 255]
    elif a==3:
        pic = cv.imread("board-Gauss-0.01.bmp", 0)
        result = [pic, 70, 180, 210, 255, 255]
    return result

def robert(img):
    img_temp = (filt.roberts(img))*255  # 进行边缘检测，得到边缘图像
    result = img_temp.astype('uint8')
    return result

def sobel(img):
    # 计算Sobel卷积结果
    x = cv.Sobel(img, cv.CV_16S, 1, 0)  # 运算时采用16位有符号整数
    y = cv.Sobel(img, cv.CV_16S, 0, 1)

    Scale_absX = cv.convertScaleAbs(x)  # 作用：先截断255再取绝对值
    Scale_absY = cv.convertScaleAbs(y)
    result = cv.addWeighted(Scale_absX, 0.5, Scale_absY, 0.5, 0)  # 图像混合，和课件不同
    return result

def laplacian(img):
    # laplacian算子：各向同性
    img_temp = cv.Laplacian(img, cv.CV_16S)
    result = cv.convertScaleAbs(img_temp)
    return result

def canny(img,a,b):
    # Canny边缘检测
    result = cv.Canny(img, a, b)
    return result

def output(pic,rob,sob,lap,canl,canh):
    pic_robert0 = robert(pic)
    pic_robert = cv.threshold(pic_robert0, rob, 255, cv.THRESH_BINARY)  # 二值化处理
    pic_sobel0 = sobel(pic)
    # pic_sobel=[0,pic_sobel0]  # tuple:用于进行通用的二值化处理
    pic_sobel = cv.threshold(pic_sobel0, sob, 255, cv.THRESH_BINARY)  # 二值化处理
    pic_laplacian0 = laplacian(pic)
    # pic_laplacian=[0,pic_laplacian0]
    pic_laplacian = cv.threshold(pic_laplacian0, lap, 255, cv.THRESH_BINARY)
    pic_canny = canny(pic,canl,canh)
    cv.imshow('robert', pic_robert[1])
    cv.imshow('sobel',pic_sobel[1])
    cv.imshow('laplacian', pic_laplacian[1])
    cv.imshow('canny', pic_canny)

while (1):

    k = cv.waitKey(1)
    if k == ord('q'):
        break

    [pic, rob, sob, lap, canl, canh] = pictreshold(button)
    output(pic, rob, sob, lap, canl, canh)


cv.waitKey(0)
cv.destroyAllWindows()
