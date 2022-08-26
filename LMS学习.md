# LMS学习

## 1 自适应滤波器简介

### 1.1 特点

​		（1）递归

​		（2）最优化（==$\mu$目前都是试出来的==）

### 1.2 分类

​		（1）横向结构、格型结构

​		（2）随机梯度、最小二乘

​		（3）成批处理、递归处理

### 1.3 应用

​		（1）消噪

​		（2）回音消除

​		（3）谱线增强

​		（4）通道均衡

​		（5）系统辨识

## 2 自适应滤波器原理

### 2.1 流程框图

![image-20220824110935493](C:\Users\59936\AppData\Roaming\Typora\typora-user-images\image-20220824110935493.png)

![image-20220824111105158](C:\Users\59936\AppData\Roaming\Typora\typora-user-images\image-20220824111105158.png)

​																					**图1** LMS算法流程框图

### 2.2 主要原理

$$
\mathbf{y(n)} = \sum_{k = 0}^{L}{w_{k}(n)x(n - k)} = \mathbf{w(n)}*\mathbf{x^{T}(n)} = \mathbf{x(n)}*\mathbf{w^{T}(n)}\\
其中，输入信号：
\mathbf{x(n)} = \left[ x(n)\ x(n - 1)\ ……\  x(n - L)  \right]\\
权矢量：\mathbf{w(n)} = \left[ w_{0}(n)\ w_{1}(n)\ ……\  w_{L}(n)  \right]\\
$$

​		误差信号：
$$
训练模式：e(n) = d(n) - y(n)\\
跟踪模式：e(n) = [\hat x^{’}(k)]_{D} - \hat x^{’}(k)
$$
​		迭代函数：其中$\mu$为迭代步长
$$
w(n + 1) = w(n) + \mu * e(n)* x(n)
$$

## 3 代码脚本

### 3.1 主函数

```matlab
clear, clc, close all

%% 产生待滤波信号
Fs = 20000; %采样频率
N = 2^12; %采样点数
t = 0: 1/Fs: N/Fs-1/Fs;%时间跨度
s = sin(2000*2*pi*t) + sin(6000*2*pi*t) + sin(9000*2*pi*t);%待滤波波形
% 归一化
% s = (s - min(s)) / (max(s) - min(s));
%% 通过高斯信道
noise = 0.05*randn(1, length(s));
s_addnoise = s + noise;
% %% RLS
% lambda = 1;
% M = 15;
% delta = 1e-7;
% [e,w,y]=RLS(lambda,M,s_addnoise',s',delta);
M = 15;
mu = 0.0234; 
[e,w,y] = LMS(mu, M, s_addnoise', s');
% %% NLMS
% M = 15;
% mu = 0.05; 
% a = 1e-4;
% [e,w,y]=NLMS(mu,M,s_addnoise',s',a);
%%  时域波形
figure(1);
subplot(3, 1, 1);
plot(t, s, 'r', 'LineWidth', 1.2);
axis([1500/Fs, 1600/Fs, 0, 1]);
title('滤波前时域波形');
subplot(3, 1, 2);
plot(t,s_addnoise,'r','LineWidth',1.2);
axis([1500/Fs, 1600/Fs, 0, 1]);
title('加噪声后时域波形');
subplot(3, 1, 3);
plot(t, y, 'r', 'LineWidth',1.2);
axis([1500/Fs, 1600/Fs, 0,1]);
title('自适应滤波后时域波形');
%% 误差曲线
figure(2);
plot(abs(e), 'r', 'LineWidth', 1.2);
title('误差曲线');
```

### 3.2 LMS子函数

```matlab
%% 最小均方误差（LMS）
function [e,w,y]=LMS(mu,M,x,d)

%% 参数定义
% 输出参数：
% e: 误差输出 
% w: 最终滤波器系数 M*1维
% y: 输出信号
 
% 输入参数：
% mu: 因子
% M：滤波器长度
% x: 输入信号，N*1维
% d: 目标信号

%% step1: 算法初始化
% 滤波器系数
w = zeros(M, 1);       % 生成 M*1 的零矩阵
y = zeros(M, 1);       % 预分配内存
% 输入向量长度
N = length(x);

%% 执行LMS
for n = M: N
    % 倒序输入
    filter_in = x(n: -1: n-M+1);
    % 计算输出
    y(n) = w' * filter_in;
    % 误差计算
    e(n) = d(n) - y(n);
    % 滤波器系数更新
    w = w + mu * filter_in * e(n);
end
```

