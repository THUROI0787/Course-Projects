""" import necessary packages """
import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import NMF, PCA, TruncatedSVD
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import LogisticRegression
from mpl_toolkits.mplot3d import Axes3D

''' load original mnist dataset '''
x_test = np.load('./MNIST_full_local/MNIST_x_test.npy')
y_test = np.load('./MNIST_full_local/MNIST_y_test.npy')
x_train = np.load('./MNIST_full_local/MNIST_x_train.npy')
y_train = np.load('./MNIST_full_local/MNIST_y_train.npy')

''' data flatten '''
x_train_flatten = []
for ii in range(60000):
    x_train_flatten.append(x_train[ii].flatten() / 255.0)

x_test_flatten = []
for ii in range(10000):
    x_test_flatten.append(x_test[ii].flatten() / 255.0)

''' feature extraction methods '''
# NMF decomposition
# estimator = NMF(n_components=8)
# PCA decomposition
# estimator = PCA(n_components=748)
# SVD decomposition
estimator = TruncatedSVD(n_components=6)

estimator.fit(x_train_flatten)

''' apply estimator to dataset '''
target_images_train_NMF = estimator.transform(x_train_flatten)
target_images_test_NMF = estimator.transform(x_test_flatten)

''' plot the 2D scatter map '''
fig = plt.figure()

idx_0 = list(np.squeeze(np.argwhere(y_train == 0)))
plt.scatter(target_images_train_NMF[idx_0, 0], target_images_train_NMF[idx_0, 1], c='r', marker='*', label='0')
idx_1 = list(np.squeeze(np.argwhere(y_train == 1)))
plt.scatter(target_images_train_NMF[idx_1, 0], target_images_train_NMF[idx_1, 1], c='g', marker='o', label='1')
idx_2 = list(np.squeeze(np.argwhere(y_train == 2)))
plt.scatter(target_images_train_NMF[idx_2, 0], target_images_train_NMF[idx_2, 1], c='b', marker=',', label='2')
idx_3 = list(np.squeeze(np.argwhere(y_train == 3)))
plt.scatter(target_images_train_NMF[idx_3, 0], target_images_train_NMF[idx_3, 1], c='k', marker='v', label='3')
idx_4 = list(np.squeeze(np.argwhere(y_train == 4)))
plt.scatter(target_images_train_NMF[idx_4, 0], target_images_train_NMF[idx_4, 1], c='c', marker='s', label='4')
idx_5 = list(np.squeeze(np.argwhere(y_train == 5)))
plt.scatter(target_images_train_NMF[idx_5, 0], target_images_train_NMF[idx_5, 1], c='m', marker='p', label='5')
idx_6 = list(np.squeeze(np.argwhere(y_train == 6)))
plt.scatter(target_images_train_NMF[idx_6, 0], target_images_train_NMF[idx_6, 1], c='y', marker='h', label='6')
idx_7 = list(np.squeeze(np.argwhere(y_train == 7)))
plt.scatter(target_images_train_NMF[idx_7, 0], target_images_train_NMF[idx_7, 1], marker='H', label='7')
idx_8 = list(np.squeeze(np.argwhere(y_train == 8)))
plt.scatter(target_images_train_NMF[idx_8, 0], target_images_train_NMF[idx_8, 1], marker='D', label='8')
idx_9 = list(np.squeeze(np.argwhere(y_train == 9)))
plt.scatter(target_images_train_NMF[idx_9, 0], target_images_train_NMF[idx_9, 1], marker='d', label='9')

plt.show()

''' plot the 3D scatter map '''
fig = plt.figure()
ax1 = Axes3D(fig)

ax1.scatter(target_images_train_NMF[idx_0[0:50], 0], target_images_train_NMF[idx_0[0:50], 1], target_images_train_NMF[idx_0[0:50], 2], c='r', marker='*', label='0')
ax1.scatter(target_images_train_NMF[idx_1[0:50], 0], target_images_train_NMF[idx_1[0:50], 1], target_images_train_NMF[idx_1[0:50], 2], c='g', marker='o', label='1')
ax1.scatter(target_images_train_NMF[idx_2[0:50], 0], target_images_train_NMF[idx_2[0:50], 1], target_images_train_NMF[idx_2[0:50], 2], c='b', marker=',', label='2')
ax1.scatter(target_images_train_NMF[idx_3[0:50], 0], target_images_train_NMF[idx_3[0:50], 1], target_images_train_NMF[idx_3[0:50], 2], c='k', marker='v', label='3')
ax1.scatter(target_images_train_NMF[idx_4[0:50], 0], target_images_train_NMF[idx_4[0:50], 1], target_images_train_NMF[idx_4[0:50], 2], c='c', marker='s', label='4')
ax1.scatter(target_images_train_NMF[idx_5[0:50], 0], target_images_train_NMF[idx_5[0:50], 1], target_images_train_NMF[idx_5[0:50], 2], c='m', marker='p', label='5')
ax1.scatter(target_images_train_NMF[idx_6[0:50], 0], target_images_train_NMF[idx_6[0:50], 1], target_images_train_NMF[idx_6[0:50], 2], c='y', marker='h', label='6')
ax1.scatter(target_images_train_NMF[idx_7[0:50], 0], target_images_train_NMF[idx_7[0:50], 1], target_images_train_NMF[idx_7[0:50], 2], marker='H', label='7')
ax1.scatter(target_images_train_NMF[idx_8[0:50], 0], target_images_train_NMF[idx_8[0:50], 1], target_images_train_NMF[idx_8[0:50], 2], marker='D', label='8')
ax1.scatter(target_images_train_NMF[idx_9[0:50], 0], target_images_train_NMF[idx_9[0:50], 1], target_images_train_NMF[idx_9[0:50], 2], marker='d', label='9')

ax1.set_xlabel('X', fontdict={'size': 15, 'color': 'black'})
ax1.set_ylabel('Y', fontdict={'size': 15, 'color': 'black'})
ax1.set_zlabel('Z', fontdict={'size': 15, 'color': 'black'})

ax1.legend(loc='best')

plt.show()

''' linear classification '''
KNN_NMF = KNeighborsClassifier(n_neighbors=12)
KNN_NMF.fit(target_images_train_NMF, y_train)
print(KNN_NMF.score(target_images_train_NMF, y_train))
print(KNN_NMF.score(target_images_test_NMF, y_test))