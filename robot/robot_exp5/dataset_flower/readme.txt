0.jpg: resize到(28,28,3)
1.jpg: 沿x轴翻转
2.jpg: 沿y轴翻转
3.jpg: 同时沿xy轴翻转
4.jpg: 旋转45度
5.jpg: 畸变 cv2.warpPerspective函数的畸变矩阵为M:
        pts1 = np.float32([[5,5],[3,25],[23,2],[27,24]])
        pts2 = np.float32([[3,5],[6,20],[17,2],[24,20]])
        M = cv2.getPerspectiveTransform(pts1, pts2)
6.jpg: 畸变 cv2.warpPerspective函数的畸变矩阵为M:
        pts1 = np.float32([[5,5],[3,25],[23,2],[27,24]])
        pts2 = np.float32([[5,3],[2,27],[26,4],[24,20]])
        M = cv2.getPerspectiveTransform(pts1, pts2)