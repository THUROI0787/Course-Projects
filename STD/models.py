import torch
import torch.nn as nn
from torch.autograd import Variable
import torch.nn.functional as F

class Res(nn.Module):
    def __init__(self,input_size,hidden_size,output_size):
        super(Res,self).__init__()
        self.input_size=input_size
        self.output_size=output_size
        self.hidden_size=hidden_size
        self.fc1=nn.Linear(self.input_size,self.hidden_size)
        self.fc2=nn.Linear(self.hidden_size,self.hidden_size)
        self.fc3=nn.Linear(self.hidden_size,self.hidden_size)
        self.fc4=nn.Linear(self.hidden_size,self.hidden_size)
        self.fc5=nn.Linear(self.hidden_size,self.hidden_size)
        self.bn=torch.nn.BatchNorm1d(self.hidden_size)
        self.init_params()
    def init_params(self):
        for m in self.modules():
            if isinstance(m,nn.Linear):
                nn.init.xavier_normal_(m.weight)
                nn.init.constant_(m.bias,0)
    def forward(self,feat):

        feat1=F.relu(self.fc1(feat))   # feat:conv?linear?
        feat2=F.relu(self.fc2(feat1))
        feat3=F.relu(feat1+self.fc3(feat2))
        feat4=F.relu(self.fc4(feat3))
        feat5=F.relu(feat3+self.fc5(feat4))
        return feat5

class Prob(nn.Module):
    def __init__(self,input_size,hidden_size):
        super(Prob,self).__init__()
        self.input_size=input_size
        self.hidden_size=hidden_size
        self.fc1=nn.Linear(self.input_size,self.hidden_size)
        self.fc2=nn.Linear(self.hidden_size,2)
        self.init_params()
    def init_params(self):
        for m in self.modules():
            if isinstance(m,nn.Linear):
                nn.init.xavier_normal_(m.weight)
                nn.init.constant_(m.bias,0)
    def forward(self,feat):
        feat=F.relu(self.fc1(feat))
        feat=self.fc2(feat)
        return feat

class FrameByFrame(nn.Module):
    def __init__(self,Vinput_size=512,Ainput_size=128,output_size=64,Vlayers_num=3,Alayers_num=2):
        super(FrameByFrame,self).__init__()
        self.Vinput_size=Vinput_size
        self.Ainput_size=Ainput_size
        self.Vlayers_num=Vlayers_num
        self.Alayers_num=Alayers_num
        self.output_size=output_size
        self.AFeatRNN = nn.LSTM(self.Ainput_size,self.output_size,self.Alayers_num)
        self.VFeatRNN = nn.LSTM(self.Vinput_size,self.output_size,self.Vlayers_num)
        self.Resmatch = Res(2*self.output_size,self.output_size,self.output_size)
        self.Prob = Prob(self.output_size,self.output_size)
    def forward(self,Vfeat,Afeat):
        h_0 = Variable(torch.zeros(self.Alayers_num, Afeat.size(0), self.output_size), requires_grad=False)
        c_0 = Variable(torch.zeros(self.Alayers_num, Afeat.size(0), self.output_size), requires_grad=False)
        h_1 = Variable(torch.zeros(self.Vlayers_num, Vfeat.size(0), self.output_size), requires_grad=False)
        c_1 = Variable(torch.zeros(self.Vlayers_num, Vfeat.size(0), self.output_size), requires_grad=False)
        if Vfeat.is_cuda:
            h_0=h_0.cuda()
            c_0=c_0.cuda()
            h_1=h_1.cuda()
            c_1=c_1.cuda()
        outAfeat,_ = self.AFeatRNN((Afeat/255.0).permute(2,0,1),(h_0,c_0))
        outVfeat,_ = self.VFeatRNN(Vfeat.permute(2,0,1),(h_1,c_1))
        Amatch_input = outAfeat[-1,:,:]
        Vmatch_input = outVfeat[-1,:,:]
        VAfeat = torch.cat((Amatch_input,Vmatch_input),dim=1)
        resfeat=self.Resmatch(VAfeat)
        prob = self.Prob(resfeat)
        return prob