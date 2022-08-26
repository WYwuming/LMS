%% 清除原有数据变量或者图像
clear, clc, close all;

%% 信号数据生成
fs = 1000;                              %采样频率
t = 0 : 1 / fs : 1 - 1 / fs;            %时间跨度
N = length(t);                          %采样点数
% [x, xn] = wnoise(2, 10, 6);             %产生噪声测试数据
x = 10 * cos(2 * pi * 50 * t + 45) + 4 * sin(2 * pi * 100 * t + 135);
xn = 5 * randn(1, N);
s = x + xn;

%% 建立自适应滤波参数
M = 100;                                 %滤波器的阶数
mu = 0.00004;                           %迭代步进
[e, w, y] = LMSFun(mu, M, s', x');     %LMS模块
figure(1);
subplot(3, 1, 1);
plot(x, 'r');
title('滤波前时域波形');
subplot(3, 1, 2);
plot(s,'r');
title('加噪声后时域波形');
subplot(3, 1, 3);
plot(y, 'r');
title('自适应滤波后时域波形');
%% 误差曲线
% figure(2);
% plot(abs(e), 'r');
% title('误差曲线');

%% 评价性能：信噪比
snrxn  = mySNR(x, s);                  %原加噪信噪比
snrlms = mySNR(x, y);                   %LMS处理后信噪比
snr1 = sprintf("未处理时信噪比: %g", snrxn)
snr2 = sprintf("LMS处理后的信噪比: %g", snrlms)

%% 评价性能：均方根误差
REMSEn = myREMSE(x, s, N);             %原加噪信号
REMSEl = myREMSE(x, y,  N);             %LMS处理后
REMSE1 = sprintf("未处理时REMSE: %g", REMSEn)
REMSE2 = sprintf("LMS处理后REMSE: %g", REMSEl)