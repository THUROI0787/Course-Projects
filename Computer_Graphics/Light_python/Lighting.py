import numpy as np
from PIL import Image
import matplotlib.pyplot as plt


def normalize(x):
    return x / np.linalg.norm(x)

def intersect(origin, dir, obj):    # 射线与物体的相交测试
    if obj['type'] == 'plane':
        return intersect_plane(origin, dir, obj['position'], obj['normal'])
    elif obj['type'] == 'sphere':
        return intersect_sphere(origin, dir, obj['position'], obj['radius'])

def intersect_plane(origin, dir, point, normal):    # 射线与平面的相交测试
    dn = np.dot(dir, normal)
    if np.abs(dn) < 1e-6:   # 射线与平面几乎平行
        return np.inf       # 交点为无穷远处
    d = np.dot(point - origin, normal) / dn         # 交点与射线原点的距离（相似三角形原理）
    return d if (d > 0) else np.inf     # 负数表示射线射向平面的反方向

def intersect_sphere(origin, dir, center, radius):  # 射线与球的相交测试
    OC = center - origin
    if (np.linalg.norm(OC) < radius) or (np.dot(OC, dir) < 0):
        return np.inf
    l = np.linalg.norm(np.dot(OC, dir))
    m_square = np.linalg.norm(OC) * np.linalg.norm(OC) - l * l
    q_square = radius*radius - m_square
    return (l - np.sqrt(q_square)) if q_square >= 0 else np.inf

def get_normal(obj, point):         # 获得物体表面某点处的单位法向量
    if obj['type'] == 'sphere':
        return normalize(point - obj['position'])
    if obj['type'] == 'plane':
        return obj['normal']

def get_color(obj, M):
    color = obj['color']
    if not hasattr(color, '__len__'):
        color = color(M)
    return color

def sphere(position, radius, color, reflection=.85, diffuse=1., specular_c=.6, specular_k=50):
    return dict(type='sphere', position=np.array(position), radius=np.array(radius),
                color=np.array(color), reflection=reflection, diffuse=diffuse, specular_c=specular_c, specular_k=specular_k)

def plane(position, normal, color=np.array([1.,1.,1.]), reflection=0.15, diffuse=.75, specular_c=.3, specular_k=50):
    return dict(type='plane', position=np.array(position), normal=np.array(normal),
                color=lambda M: (np.array([1.,1.,1.]) if (int((M[0]+500)*4)%2) == (int((M[2]+500)*4)%2) else (np.array([0.,0.,0.]))),
                reflection=reflection, diffuse=diffuse, specular_c=specular_c, specular_k=specular_k)

scene = [sphere([.75, .1, 1.], .5, [.0, .0, .9]),           # 球心位置[XZY]，半径，颜色
         sphere([-.22, .5, .2], .24, [.1, .572, .184]),
         sphere([-2.75, .1, 3.5], .65, [.8, .3, 0.]),
         plane([0., -.5, 0.], [0., 1., 0.])]                # 平面上一点的位置，法向量
light_point = np.array([5., 5., -10.])                      # 点光源位置
light_color = np.array([1., 1., 1.])                        # 点光源的颜色值[RGB]
ambient = 0.12                                              # 环境光

# 核心代码
def intersect_color(origin, dir, intensity):
    min_distance = np.inf
    for i, obj in enumerate(scene):
        current_distance = intersect(origin, dir, obj)
        if current_distance < min_distance:
            min_distance, obj_index = current_distance, i   # 记录最近的交点距离和对应的物体
    if (min_distance == np.inf) or (intensity < 0.01):
        return np.array([0., 0., 0.])

    obj = scene[obj_index]
    P = origin + dir * min_distance       # 交点坐标
    color = get_color(obj, P)
    N = get_normal(obj, P)                # 交点处单位法向量
    PL = normalize(light_point - P)
    PO = normalize(origin - P)

    c = ambient * color

    l = [intersect(P + N * .0001, PL, obj_shadow_test)
            for i, obj_shadow_test in enumerate(scene) if i != obj_index]       # 阴影测试
    if not (l and min(l) < np.linalg.norm(light_point - P)):
        c += obj['diffuse'] * max(np.dot(N, PL), 0) * color * light_color
        c += obj['specular_c'] * max(np.dot(N, normalize(PL + PO)), 0) ** obj['specular_k'] * light_color

    # # 递归操作实现反射的视觉效果
    # reflect_ray = dir - 2 * np.dot(dir, N) * N  # 计算反射光线
    # c += obj['reflection'] * intersect_color(P + N * .0001, reflect_ray, obj['reflection'] * intensity)

    return np.clip(c, 0, 1)

def snap(h, w, Q, O):
    r = np.float32(w) / h
    S = (-1., -1. / r + .25, 1., 1. / r + .25)
    img = np.zeros((h, w, 3))
    for i, x in enumerate(np.linspace(S[0], S[2], w)):
        if i % 8 == 0:
            print("%.2f" % (i / np.float32(w) * 100), "%")
        for j, z in enumerate(np.linspace(S[1], S[3], h)):
            Q[:2] = (x, z)
            img[h - j - 1, i, :] = intersect_color(O, normalize(Q - O), 1)
    return img

w, h = 400, 300     # 屏幕宽高
O1 = np.array([0., 0.35, -1.])   # 摄像机位置
Q1 = np.array([0., 0., 0.])      # 摄像机指向
# O2 = np.array([0., 0.35, -1.])
# Q2 = np.array([0., 0., 0.])

img1 = snap(h, w, Q1, O1)
# img2 = snap(h, w, Q2, O2)

# plt.imsave('test3.png', img)
plt.imshow(img1)
plt.show()