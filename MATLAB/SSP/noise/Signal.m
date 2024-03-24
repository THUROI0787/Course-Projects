close all;clear;clc;

%% 1.信号的生成
N=10000;eposi=0.9;
M=50;  % M需要自己指定
x=zeros(N,M);
n=ones(N,1);
flag=logical(1-binornd(n,eposi));  % 每条信号的真实假设
h0=randn(N,M);
h1=1+randn(N,M);
for i=1:N
    x(i,:)=flag(i)*h1(i,:)+(1-flag(i))*h0(i,:);
end
% ---至此已生成结果flag矩阵和信号x矩阵，以下进行各信号均值的验证---
x_mean=mean(x,2);  % 每一个信号多次观测值的平均值（每行取平均）
eposi_mean=1-mean(flag);  % flag的平均值，和先验概率eposi作比较，需要基本相等
x_flag=zeros(N,1,'logical');
for i=1:N
    if abs(x_mean(i)-flag(i))<=0.25  % 0.1是自己设置的一个比较粗糙的阈值，用来判断该信号是否和flag相同
        x_flag(i)=1;
    end
end
x_flag_ans=sum(x_flag);  % 若所得极接近N（1000），说明信号设置无误。

%% 2.最大后验概率准则
pred=zeros(N,1,'logical');
% syms r;
% lambda = exp((2*r-1)/2)==eposi/(1-eposi);  % 最大后验概率判决准则
% VT=double(solve(lambda,r));
VT=log(eposi/(1-eposi))+1/2;
for i=1:N
    if x(i,1)>=VT
        pred(i)=1;
    else
        pred(i)=0;
    end
end
pred_flag_ans=sum(abs(pred-flag));
PF=0;  % 虚警概率：H1|H0
PM=0;  % 漏检概率：H0|H1
PD=0;  % 检测概率：H1|H1；PM+PD=1
PWrong=0;  % 平均错误概率：H1|H0 & H0|H1
PRight=0;  % 平均正确概率：PRight+PWrong=1
% 注意这几者都是条件概率，分母不一定相同
H1_num=sum(flag);
for i=1:N
    if flag(i)==1
        if pred(i)==0
            PM=PM+1/H1_num;
            PWrong=PWrong+1/N;
        else
            PD=PD+1/H1_num;
            PRight=PRight+1/N;
        end
    else  % flag(i)==0
        if pred(i)==0
            PRight=PRight+1/N;
        else
            PF=PF+1/(N-H1_num);
            PWrong=PWrong+1/N;
        end
    end
end 
% 发现问题：H0被识别出来的概率非常大，pred中很少有H1.

%% 3.多次观测的最大后验概率准则
PWrong3=zeros(1,M);
PRight3=zeros(1,M);
pred3=zeros(N,M,'logical');
VT3=zeros(1,M);  % 阈值VT会随着观测点个数发生变化
x_row_sum=zeros(N,1);  % 表示某一行前i个数的和
for i=1:M
    VT3(i)=(log(eposi/(1-eposi)))/i+1/2;
    for j=1:N
        x_row_sum(j)=x_row_sum(j)+x(j,i);
        if (x_row_sum(j)/i)>=VT3(i)
            pred3(j,i)=1;
            if flag(j)==1
                PRight3(i)=PRight3(i)+1/N;
            else
                PWrong3(i)=PWrong3(i)+1/N;
            end
        else
            pred3(j,i)=0;
            if flag(j)==1
                PWrong3(i)=PWrong3(i)+1/N;
            else
                PRight3(i)=PRight3(i)+1/N;
            end
        end
    end
end
figure;plot([1:1:M],PWrong3);
title("T3-多次观测的最大后验概率准则");
xlabel("观测点数目M");ylabel("平均错误概率PWrong");

%% 4.贝叶斯准则
C_01=10; C_10=100; C_00=0; C_11=0;
% 多观测点的判决准则和最大后验概率准则类似，添上代价因子即可。
PF4=zeros(1,M);  % 虚警概率：H1|H0
PM4=zeros(1,M);  % 漏检概率：H0|H1
pred4=zeros(N,M,'logical');
VT_Bayes=zeros(1,M);
C=zeros(1,M);  % 平均代价
x_row_sum=zeros(N,1);  % 表示某一行前i个数的和
for i=1:M
    VT_Bayes(i)=(log(eposi*(C_10-C_00)/((1-eposi)*(C_01-C_11))))/i+1/2;
    for j=1:N
        x_row_sum(j)=x_row_sum(j)+x(j,i);
        if ((x_row_sum(j)/i)>=VT_Bayes(i))
            pred4(j,i)=1;
            if flag(j)==0  % 虚警
                PF4(i)=PF4(i)+1/(1-H1_num);
                C(i)=C(i)+C_10/N;
            else
                C(i)=C(i)+C_11/N;
            end
        else
            pred4(j,i)=0;
            if flag(j)==1  % 漏检
                PM4(i)=PM4(i)+1/H1_num;
                C(i)=C(i)+C_01/N;
            else
                C(i)=C(i)+C_00/N;
            end
        end
    end
end
figure;plot([1:1:M],C);
title("T4-多次观测的贝叶斯准则");
xlabel("观测点数目M");ylabel("最小代价C");

%% 5.广义似然比检验
% 对于未知的a，判决规则为|sum(x(i,:))/sqrt(M)|和r1，将r1调大即可。
% 随着将r1调大的过程，虚警概率PF和检测概率PD都从1减小至0.
% 固定M不动即可，当M>=20时ROC面积几乎就已经是1了，可见多次观测可以极大提升性能.
PF5=zeros(1,200);PD5=zeros(1,200);
r1=[0.01:0.1:20];
for j=1:200
    for i=1:N
        if abs(sum(x(i,:))/sqrt(M))>=r1(j)
            if flag(i)==1
                PD5(j)=PD5(j)+1/H1_num;
            else
                PF5(j)=PF5(j)+1/(N-H1_num);
            end
        end
    end
end
figure;plot(PF5,PD5);
title("T5-广义似然比检验-M=20");
xlabel("虚警概率PF");ylabel("检测概率PD");

%% 6.序贯检测
Sam_num=zeros(N,1);  % 每个信号要完成序贯检测需要的抽样数目
alfa=0.1;beta=0.1;
lam0=beta/(1-alfa);
lam1=(1-beta)/alfa;
KH1_sum=0;KH0_sum=0;
for i=1:N
    sumk=0;  % 某个信号（每行）前k个之和
    for j=1:M
        sumk=sumk+x(i,j);
        if (sumk-j/2)>=log(lam1)
            Sam_num(i)=j;
            break;
        elseif (sumk-j/2)<=log(lam0)
            Sam_num(i)=j;
            break;
        else
            Sam_num(i)=M;
        end
    end
    if (flag(i)==1)
        KH1_sum=KH1_sum+Sam_num(i);
    else
        KH0_sum=KH0_sum+Sam_num(i);
    end
end
EKH0=KH0_sum/(N-H1_num);
EKH1=KH1_sum/H1_num;