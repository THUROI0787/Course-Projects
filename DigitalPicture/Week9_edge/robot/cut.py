import cv2
import numpy as np

def detect_and_transform(image):
    # 转换为灰度图像
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # 边缘检测
    edges = cv2.Canny(gray, 20, 300)

    # 膨胀操作
    dilated = cv2.dilate(edges, None, iterations=1)

    # 查找轮廓
    contours, _ = cv2.findContours(dilated.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    # training: edges; test: dilated

    max_area = 0
    best_contour = None

    for contour in contours:
        # 近似轮廓
        epsilon = 0.1 * cv2.arcLength(contour, True)
        approx = cv2.approxPolyDP(contour, epsilon, True)

        # 如果近似轮廓有四个顶点，则认为是矩形
        if len(approx) == 4:
            x, y, w, h = cv2.boundingRect(approx)

            # 检查宽度和长度是否在指定范围内
            if w >= 30 and h >= 60 and h/w >= 1.6 and h/w <= 2.5:
                area = cv2.contourArea(contour)

                # 选择最大面积的矩形
                if area > max_area:
                    max_area = area
                    best_contour = approx


    # 如果找到最佳矩形的轮廓
    if best_contour is not None:
        # 裁剪矩形区域
        screen = four_point_transform(image, best_contour.reshape(4, 2))

        # 进行透视变换，将矩形调整为统一大小的矩形
        transformed_screen = perspective_transform(screen)

        return transformed_screen

    else:
        return None


def four_point_transform(image, pts):
    # 提取四个顶点坐标
    rect = np.zeros((4, 2), dtype=np.float32)
    sums = np.sum(pts, axis=1)
    # 根据和的大小进行排序
    sorted_indices = np.argsort(sums)
    # 使用排序后的索引对 pts 进行重新排序
    pts = pts[sorted_indices]
    rect[0] = pts[0]
    rect[1] = pts[1]
    rect[3] = pts[2]
    rect[2] = pts[3]

    # 计算新图像的宽度和高度
    width = max(np.linalg.norm(rect[0] - rect[1]), np.linalg.norm(rect[2] - rect[3]))
    height = max(np.linalg.norm(rect[0] - rect[3]), np.linalg.norm(rect[1] - rect[2]))

    # 创建目标图像的坐标
    dst = np.array([[0, 0],
                    [width - 1, 0],
                    [width - 1, height - 1],
                    [0, height - 1]], dtype=np.float32)

    # 计算透视变换矩阵
    M = cv2.getPerspectiveTransform(rect, dst)

    # 应用透视变换
    warped = cv2.warpPerspective(image, M, (int(width), int(height)))

    return warped


def perspective_transform(image):
    # 定义目标图像大小
    target_width = 100
    target_height = 200

    # 调整图像大小
    # img = cv2.rotate(image, cv2.ROTATE_90_CLOCKWISE)
    resized = cv2.resize(image, (target_width, target_height))

    return resized

for j in range(1, 13):
    for i in range(1, 101):
        image_path = "C:/Users/86150/Desktop/code/robot_final/dataset/class"+ str(j) + "/" + str(i) + ".jpg"
        # 读取图像
        image = cv2.imread(image_path)

        # 检测并转换图像
        transformed_image = detect_and_transform(image)

        if transformed_image is not None:
            # 显示转换后的图像
            img = "C:/Users/86150/Desktop/code/robot_final/dataset_cut/class"+ str(j) + "/" + str(i) + ".jpg"
            cv2.imwrite(img, transformed_image)
        else:
            print(j, "_", i)
