""" import necessary packages """
import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import NMF, PCA
from sklearn.neighbors import KNeighborsClassifier
from sklearn.datasets import load_iris
from mpl_toolkits.mplot3d import Axes3D

''' load original iris dataset '''
iris_dataset = load_iris()
x = iris_dataset.data
y = iris_dataset.target

''' feature extraction methods '''
# PCA decomposition (Using PCs = 3 here indicating that the maximum amount of PC we need to use is 3.)
estimator = PCA(n_components=3)
# get the projection parameters for dataset 'x'
estimator.fit(x)

''' apply extractor to dataset '''
# projecting the 'x' dataset to a 3-Dim space
x_PCA = estimator.transform(x)

''' plot the 1D scatter map '''
fig = plt.figure()

idx_0 = list(np.squeeze(np.argwhere(y == 0)))
plt.scatter(x_PCA[idx_0, 0], np.zeros(50), label='0')

idx_1 = list(np.squeeze(np.argwhere(y == 1)))
plt.scatter(x_PCA[idx_1, 0], np.zeros(50), label='1')

idx_2 = list(np.squeeze(np.argwhere(y == 2)))
plt.scatter(x_PCA[idx_2, 0], np.zeros(50), label='2')

plt.legend(loc='best')
plt.show()

''' plot the 2D scatter map '''
fig = plt.figure()

idx_0 = list(np.squeeze(np.argwhere(y == 0)))
plt.scatter(x_PCA[idx_0, 0], x_PCA[idx_0, 1], label='0')

idx_1 = list(np.squeeze(np.argwhere(y == 1)))
plt.scatter(x_PCA[idx_1, 0], x_PCA[idx_1, 1], label='1')

idx_2 = list(np.squeeze(np.argwhere(y == 2)))
plt.scatter(x_PCA[idx_2, 0], x_PCA[idx_2, 1], label='2')

plt.legend(loc='best')
plt.show()

''' plot the 3D scatter map '''
fig = plt.figure()
ax1 = Axes3D(fig)

ax1.scatter(x_PCA[idx_0, 0], x_PCA[idx_0, 1], x_PCA[idx_0, 2], c='r', marker='*', label='0')
ax1.scatter(x_PCA[idx_1, 0], x_PCA[idx_1, 1], x_PCA[idx_1, 2], c='g', marker='o', label='1')
ax1.scatter(x_PCA[idx_2, 0], x_PCA[idx_2, 1], x_PCA[idx_2, 2], c='b', marker=',', label='2')

ax1.set_xlabel('X', fontdict={'size': 15, 'color': 'black'})
ax1.set_ylabel('Y', fontdict={'size': 15, 'color': 'black'})
ax1.set_zlabel('Z', fontdict={'size': 15, 'color': 'black'})

ax1.legend(loc='best')

plt.show()

''' linear classification (K-nearest neighbors votes) '''
KNN_PCA = KNeighborsClassifier(n_neighbors=12)

# using 1 PC for linear classification
KNN_PCA.fit(x_PCA[:, 0:1], y)
print(KNN_PCA.score(x_PCA[:, 0:1], y))

# using 2 PCs for linear classification
KNN_PCA.fit(x_PCA[:, 0:2], y)
print(KNN_PCA.score(x_PCA[:, 0:2], y))

# using 3 PCs for linear classification
KNN_PCA.fit(x_PCA[:, 0:3], y)
print(KNN_PCA.score(x_PCA[:, 0:3], y))
