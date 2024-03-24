import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import NMF, PCA
from sklearn import preprocessing
from sklearn.neighbors import KNeighborsClassifier
from mpl_toolkits.mplot3d import Axes3D

#  scaler = preprocessing.StandardScaler().fit(data)

data=[]
target=[]
data_test=[]
target_test=[]
idx_0=[]
idx_1=[]
idx_7=[]
for i in range(16):  # 0_train:0~15
    sheet_soce="0_0"+str(i+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\0_train.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data.append(np.array(data_prep).flatten())
    target.append(0)
    idx_0.append(i)
for j in range(17):   # 1_train:0~16
    sheet_soce="1_0"+str(j+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\1_train.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data.append(np.array(data_prep).flatten())
    target.append(1)
    idx_1.append(j+16)
for k in range(18):   # 7_train:0~17
    sheet_soce="7_0_"+str(k+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\7_train.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data.append(np.array(data_prep).flatten())
    target.append(7)
    idx_7.append(k+33)

for x in range(4):  # test
    sheet_soce="0_0"+str(x+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\0_test.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data_test.append(np.array(data_prep).flatten())
    target_test.append(0)
for y in range(4):  # test
    sheet_soce="1_0"+str(y+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\1_test.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data_test.append(np.array(data_prep).flatten())
    target_test.append(1)
for z in range(4):  # test
    sheet_soce="7_0"+str(z+1)
    data_soce = pd.read_excel(r"C:\Users\86150\Desktop\SRT_data\Data\7_test.xlsx", sheet_name=sheet_soce, header=0)
    data_prep = preprocessing.StandardScaler().fit_transform(data_soce)
    data_test.append(np.array(data_prep).flatten())
    target_test.append(7)


estimator = PCA(n_components=4)
# estimator = NMF(n_components=3)
# estimator = TruncatedSVD(n_components=6)
estimator.fit(data)
data_PCA = estimator.transform(data)
test_PCA = estimator.transform(data_test)

'''2D picture'''
fig = plt.figure()
plt.scatter(data_PCA[idx_0, 0], data_PCA[idx_0, 1], c='r', marker='*', label='0')
plt.scatter(data_PCA[idx_1, 0], data_PCA[idx_1, 1], c='g', marker='o', label='1')
plt.scatter(data_PCA[idx_7, 0], data_PCA[idx_7, 1], c='b', marker=',', label='7')
plt.legend(loc='best')
plt.show()

'''3D picture'''
fig = plt.figure()
ax1 = Axes3D(fig)
ax1.scatter(data_PCA[idx_0, 0], data_PCA[idx_0, 1], data_PCA[idx_0, 2], c='r', marker='*', label='0')
ax1.scatter(data_PCA[idx_1, 0], data_PCA[idx_1, 1], data_PCA[idx_1, 2], c='g', marker='o', label='1')
ax1.scatter(data_PCA[idx_7, 0], data_PCA[idx_7, 1], data_PCA[idx_7, 2], c='b', marker=',', label='7')

ax1.set_xlabel('X', fontdict={'size': 15, 'color': 'black'})
ax1.set_ylabel('Y', fontdict={'size': 15, 'color': 'black'})
ax1.set_zlabel('Z', fontdict={'size': 15, 'color': 'black'})
ax1.legend(loc='best')
plt.show()

''' linear classification '''
KNN_NMF = KNeighborsClassifier(n_neighbors=12)
KNN_NMF.fit(data_PCA[:, 0:3], target)
print(KNN_NMF.score(data_PCA[:, 0:3], target))
print(KNN_NMF.score(test_PCA[:, 0:3], target_test))
