import numpy as np
import cv2

pic = cv2.imread("1a.jpg")  # B'G'R'
mask = cv2.imread("1b.jpg")
bg = cv2.imread("bg1.jpg")
output = pic
mask1 = cv2.resize(mask, (pic.shape[1], pic.shape[0]))  # resize:(width,height)
bg1 = cv2.resize(bg, (pic.shape[1], pic.shape[0]))

dimen = np.zeros((pic.shape[0], pic.shape[1], 1), dtype=int)  # append
mask0 = np.concatenate((mask1, dimen), axis=2)

for i in range(0, pic.shape[0]):
    for j in range(0, pic.shape[1]):
        mask0[i, j, 3] = 1 if (mask0[i, j, 0] + mask0[i, j, 1] + mask0[i, j, 2]) / 3 > 240 else 0
        output[i,j,:] = pic[i,j,:]*mask0[i,j,3] + bg1[i,j,:]*(1-mask0[i,j,3])

# output = np.array(mask0[:,:,0:3], dtype=np.uint8)
cv2.imshow("output", output)
# cv2.imwrite("1_mix_3.jpg",output)
cv2.waitKey(0)
cv2.destroyAllWindows()