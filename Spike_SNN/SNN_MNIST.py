import argparse
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.utils.data as data
import torchvision
import numpy as np
from spikingjelly.clock_driven import neuron, encoding, functional,layer
from torch.utils.tensorboard import SummaryWriter
from tqdm import tqdm

parser = argparse.ArgumentParser(description='spikingjelly LIF MNIST Training')

parser.add_argument('--device', default='cuda:0',
                    help='运行的设备，例如“cpu”或“cuda:0”\n Device, e.g., "cpu" or "cuda:0"')

parser.add_argument('--dataset-dir', default='./MNIST',
                    help='保存MNIST数据集的位置，例如“./”\n Root directory for saving MNIST dataset, e.g., "./"')
parser.add_argument('--log-dir', default='./',
                    help='保存tensorboard日志文件的位置，例如“./”\n Root directory for saving tensorboard logs, e.g., "./"')
parser.add_argument('--model-output-dir', default='./',
                    help='模型保存路径，例如“./”\n Model directory for saving, e.g., "./"')

parser.add_argument('-b', '--batch-size', default=1, type=int, help='Batch 大小，例如“64”\n Batch size, e.g., "64"')
parser.add_argument('-T', '--timesteps', default=100, type=int, dest='T',
                    help='仿真时长，例如“100”\n Simulating timesteps, e.g., "100"')
parser.add_argument('--lr', '--learning-rate', default=1e-3, type=float, metavar='LR',
                    help='学习率，例如“1e-3”\n Learning rate, e.g., "1e-3": ', dest='lr')
parser.add_argument('--tau', default=2.0, type=float,
                    help='LIF神经元的时间常数tau，例如“100.0”\n Membrane time constant, tau, for LIF neurons, e.g., "100.0"')
parser.add_argument('-N', '--epoch', default=10, type=int, help='训练epoch，例如“100”\n Training epoch, e.g., "100"')

tau_pre = 100
tau_post = 100
trace_pre = []
trace_post = []
s_pre = []
s_post = []
w = torch.zeros(28*28,10)  #28*28行10列
def f_pre(x):
    return x.abs() + 0.1

def f_post(x):
    return - f_pre(x)

def neuronal_charge(self, x: torch.Tensor):
    if self.v_reset is None:
        self.v += (x - self.v) / self.tau

    else:
        if isinstance(self.v_reset, float) and self.v_reset == 0.:
            self.v += (x - self.v) / self.tau
        else:
            self.v += (x - (self.v - self.v_reset)) / self.tau
#按照新版stdp更改
def stdp(self, s_pre: torch.Tensor, s_post: torch.Tensor, module: nn.Module, learning_rate: float):
    if self.trace_pre is None:
        self.trace_pre = 0.
    if self.trace_post is None:
        self.trace_post = 0.

    if isinstance(module, nn.Linear):
        # update trace
        self.trace_pre += - self.trace_pre / self.tau_pre + s_pre
        self.trace_post += - self.trace_post / self.tau_post + s_post

        # update weight
        delta_w_pre = -self.f_pre(module.weight) * (self.trace_post.unsqueeze(2) * s_pre.unsqueeze(1)).sum(0)   #sum(0) 求数组每一列的和
        delta_w_post = self.f_post(module.weight) * (self.trace_post.unsqueeze(2) * s_post.unsqueeze(1)).sum(0)
        module.weight += (delta_w_pre + delta_w_post) * learning_rate
    else:
        raise NotImplementedError


def main():
    '''
    :return: None

    * :ref:`API in English <lif_fc_mnist.main-en>`

    .. _lif_fc_mnist.main-cn:

    使用全连接-LIF的网络结构，进行MNIST识别。\n
    这个函数会初始化网络进行训练，并显示训练过程中在测试集的正确率。

    * :ref:`中文API <lif_fc_mnist.main-cn>`

    .. _lif_fc_mnist.main-en:

    The network with FC-LIF structure for classifying MNIST.\n
    This function initials the network, starts trainingand shows accuracy on test dataset.
    '''

    args = parser.parse_args()
    print("########## Configurations ##########")
    print('\n'.join(f'{k}={v}' for k, v in vars(args).items()))
    print("####################################")

    device = args.device
    dataset_dir = args.dataset_dir
    log_dir = args.log_dir
    model_output_dir = args.model_output_dir
    batch_size = args.batch_size
    lr = args.lr
    T = args.T
    tau = args.tau
    train_epoch = args.epoch

    writer = SummaryWriter(log_dir)

    # 初始化数据加载器
    train_dataset = torchvision.datasets.MNIST(
        root=dataset_dir,
        train=True,
        transform=torchvision.transforms.ToTensor(),
        download=True
    )
    test_dataset = torchvision.datasets.MNIST(
        root=dataset_dir,
        train=False,
        transform=torchvision.transforms.ToTensor(),
        download=True
    )

    train_data_loader = data.DataLoader(
        dataset=train_dataset,
        batch_size=batch_size,
        shuffle=True,
        drop_last=True
    )
    test_data_loader = data.DataLoader(
        dataset=test_dataset,
        batch_size=batch_size,
        shuffle=False,
        drop_last=False
    )

    # 定义并初始化网络
    net = nn.Sequential(
        nn.Flatten(),
        nn.Linear(28 * 28, 10, bias=False),
        neuron.LIFNode(tau=tau, v_threshold=1.2, v_reset=0.1),  # tau 膜电位时间常数 不定义反向传播surrogate_function=surrogate.ATan()
    )
    layer.STDPLearner(tau_pre, tau_post, f_pre, f_post)
    net = net.to(device)
    # 使用Adam优化器
    optimizer = torch.optim.Adam(net.parameters(), lr=lr)
    # 使用泊松编码器
    encoder = encoding.PoissonEncoder()
    train_times = 0
    max_test_accuracy = 0

    test_accs = []
    train_accs = []

    for epoch in range(train_epoch):
        print("Epoch {}:".format(epoch))
        print("Training...")
        train_correct_sum = 0
        train_sum = 0
        net.train()
        for img, label in tqdm(train_data_loader):
            img = img.to(device)
            label = label.to(device)
            label_one_hot = F.one_hot(label, 10).float()
            encoded_img = torch.zeros([100,28, 28], dtype=torch.float)  ####这里无法加变量，因此args.T要更改时，这里的100也需更改
            lif_node = torch.zeros([100, 10], dtype=torch.float)  ####这里无法加变量，因此args.T要更改时，这里的100也需更改
            inlif = torch.zeros([100,28*28])
            optimizer.zero_grad()

            # 运行T个时长，out_spikes_counter是shape=[batch_size, 10]的tensor
            # 记录整个仿真时长内，输出层的10个神经元的脉冲发放次数
            for t in range(T):
                if t == 0:
                     # 泊松编码：按照灰度比随即激发，每个时间t相互独立
                    #out_spikes_counter = net(encoder(img).float())
                    encoded_img[t] = encoder(img)
                    inlif = encoded_img[t].reshape(1,-1)
                    lif_node[t] = net(inlif)
                else:
                      # 泊松编码：按照灰度比随即激发，每个时间t相互独立
                    #out_spikes_counter += net(encoder(img).float())
                    encoded_img[t] = encoder(img)
                    inlif = encoded_img[t].reshape(1, -1)
                    lif_node[t] = net(inlif)

            s_pre = encoded_img
            s_pre = s_pre.reshape(2, -1)   #降维得到100行 28*28列
            s_post = lif_node[:, label_one_hot]
            for tt in range(28 * 28):
                layer.STDPLearner.stdp(s_pre[:, tt], s_post, layer, 1e-2)
                trace_pre.append(layer.STDPLearner.trace_pre.item())
                trace_post.append(layer.STDPLearner.trace_post.item())
                w[:, label_one_hot].append(layer.weight.item())

            out_spikes_counter = np.sum(lif_node,axis=0)
            out_spikes_counter_frequency = out_spikes_counter / T

            # 损失函数为输出层神经元的脉冲发放频率，与真实类别的MSE
            # 这样的损失函数会使，当类别i输入时，输出层中第i个神经元的脉冲发放频率趋近1，而其他神经元的脉冲发放频率趋近0
            loss = F.mse_loss(out_spikes_counter_frequency, label_one_hot)
            optimizer.step()
            # 优化一次参数后，需要重置网络的状态，因为SNN的神经元是有“记忆”的
            functional.reset_net(net)

            # 正确率的计算方法如下。认为输出层中脉冲发放频率最大的神经元的下标i是分类结果
            train_correct_sum += (out_spikes_counter_frequency.max(1)[1] == label.to(device)).float().sum().item()
            train_sum += label.numel()

            train_batch_accuracy = (out_spikes_counter_frequency.max(1)[1] == label.to(device)).float().mean().item()
            writer.add_scalar('train_batch_accuracy', train_batch_accuracy, train_times)
            train_accs.append(train_batch_accuracy)

            train_times += 1
        train_accuracy = train_correct_sum / train_sum

        print("Testing...")
        net.eval()
        with torch.no_grad():
            # 每遍历一次全部数据集，就在测试集上测试一次
            test_correct_sum = 0
            test_sum = 0
            for img, label in tqdm(test_data_loader):
                img = img.to(device)
                for t in range(T):
                    if t == 0:
                        out_spikes_counter = net(encoder(img).float())
                    else:
                        out_spikes_counter += net(encoder(img).float())

                test_correct_sum += (out_spikes_counter.max(1)[1] == label.to(device)).float().sum().item()
                test_sum += label.numel()
                functional.reset_net(net)
            test_accuracy = test_correct_sum / test_sum
            writer.add_scalar('test_accuracy', test_accuracy, epoch)
            test_accs.append(test_accuracy)
            max_test_accuracy = max(max_test_accuracy, test_accuracy)
        print("Epoch {}: train_acc = {}, test_acc={}, max_test_acc={}, train_times={}".format(epoch, train_accuracy,
                                                                                              test_accuracy,
                                                                                              max_test_accuracy,
                                                                                              train_times))
        print()

    # 保存模型
    torch.save(net, model_output_dir + "/lif_snn_mnist.ckpt")
    # 读取模型
    # net = torch.load(model_output_dir + "/lif_snn_mnist.ckpt")

    # 保存绘图用数据
    net.eval()
    # 注册钩子
    output_layer = net[-1]  # 输出层
    output_layer.v_seq = []
    output_layer.s_seq = []

    def save_hook(m, x, y):
        m.v_seq.append(m.v.unsqueeze(0))
        m.s_seq.append(y.unsqueeze(0))

    output_layer.register_forward_hook(save_hook)

    with torch.no_grad():
        img, label = test_dataset[0]
        img = img.to(device)
        for t in range(T):
            if t == 0:
                out_spikes_counter = net(encoder(img).float())
            else:
                out_spikes_counter += net(encoder(img).float())
        out_spikes_counter_frequency = (out_spikes_counter / T).cpu().numpy()
        print(f'Firing rate: {out_spikes_counter_frequency}')

        output_layer.v_seq = torch.cat(output_layer.v_seq)
        output_layer.s_seq = torch.cat(output_layer.s_seq)
        v_t_array = output_layer.v_seq.cpu().numpy().squeeze().T  # v_t_array[i][j]表示神经元i在j时刻的电压值
        np.save("v_t_array.npy", v_t_array)
        s_t_array = output_layer.s_seq.cpu().numpy().squeeze().T  # s_t_array[i][j]表示神经元i在j时刻释放的脉冲，为0或1
        np.save("s_t_array.npy", s_t_array)

    train_accs = np.array(train_accs)
    np.save('train_accs.npy', train_accs)
    test_accs = np.array(test_accs)
    np.save('test_accs.npy', test_accs)


if __name__ == '__main__':
    main()