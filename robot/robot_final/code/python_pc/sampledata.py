import os
import random
# import matplotlib.pyplot as plt
import re
import numpy as np
from PIL import Image

import argparse

data_path = '../../dataset_cut'
label = []
class_num = 12
# self.transform = transform
random_seed = 42
random.seed(random_seed)
for i in range(12):
    image_files = os.listdir('{}/class{}'.format(data_path, i + 1))
    os.mkdir('../../dataset_random/class'+str(i+1))
    file_count = len(image_files)
    random.shuffle(image_files)

    for j in range(file_count):
        image = Image.open(
            '{}/class{}/{}'.format(data_path, i + 1, image_files[j])).convert('RGB')
        image.save('../../dataset_random/class'+str(i+1)+'/'+str(j+1)+'.jpg')