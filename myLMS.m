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