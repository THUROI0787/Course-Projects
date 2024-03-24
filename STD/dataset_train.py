seed = 42
test_num = 804
total_num = 3339

from shutil import copyfile
import os
import random

random.seed(seed)
index_list = [str(i).zfill(4) for i in range(total_num)]
random.shuffle(index_list)

os.makedirs('STD_data/Train&Test/Train_'+str(seed), exist_ok=True)
os.makedirs('STD_data/Train&Test/Train_'+str(seed)+'/afeat', exist_ok=True)
os.makedirs('STD_data/Train&Test/Train_'+str(seed)+'/vfeat', exist_ok=True)
os.makedirs('STD_data/Train&Test/Test_'+str(seed), exist_ok=True)
os.makedirs('STD_data/Train&Test/Test_'+str(seed)+'/afeat', exist_ok=True)
os.makedirs('STD_data/Train&Test/Test_'+str(seed)+'/vfeat', exist_ok=True)

train_afeat_path = 'STD_data/Train&Test/Train_'+str(seed)+'/afeat'
train_vfeat_path = 'STD_data/Train&Test/Train_'+str(seed)+'/vfeat'
test_afeat_path = 'STD_data/Train&Test/Test_'+str(seed)+'/afeat'
test_vfeat_path = 'STD_data/Train&Test/Test_'+str(seed)+'/vfeat'

for i in range(total_num):
    print(index_list[i])
    if i < test_num:
        copyfile('STD_data/Train/afeat/'+index_list[i]+'.npy',test_afeat_path+'/%04d.npy'%i)
        copyfile('STD_data/Train/vfeat/'+index_list[i]+'.npy',test_vfeat_path+'/%04d.npy'%i)
    else:
        copyfile('STD_data/Train/afeat/'+index_list[i]+'.npy',train_afeat_path+'/%04d.npy'%(i-test_num))
        copyfile('STD_data/Train/vfeat/'+index_list[i]+'.npy',train_vfeat_path+'/%04d.npy'%(i-test_num))