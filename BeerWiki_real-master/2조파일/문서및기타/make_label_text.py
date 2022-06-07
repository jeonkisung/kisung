# -*- coding: utf-8 -*-
import numpy as np
import os

abs_dir = 'C:\\Users\\yourm\\Desktop\\2조 프로젝트\\맥주-20220509T041229Z-001\\맥주\\통합'
save_dir = 'C:\\Users\\yourm\\Desktop\\2조 프로젝트\\맥주-20220504T093646Z-001\\맥주'
dir_list = os.listdir(abs_dir)
print('dir_list : ', dir_list)

bear_ary = []
bear_target = []
for dir_name in dir_list:
    bear_target.append(dir_name)

bear_target = np.array(bear_target)

with open(os.path.join(save_dir,'labels.txt'), 'w', encoding='utf8') as f:
    for line in bear_target:
        f.write(line.replace('라벨', '').strip())
        f.write('\n')






