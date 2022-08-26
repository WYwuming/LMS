clear, clc, close all

%% �������˲��ź�
Fs = 20000; %����Ƶ��
N = 2^12; %��������
t = 0: 1/Fs: N/Fs-1/Fs;%ʱ����
s = sin(2000*2*pi*t) + sin(6000*2*pi*t) + sin(9000*2*pi*t);%���˲�����
% ��һ��
% s = (s - min(s)) / (max(s) - min(s));
%% ͨ����˹�ŵ�
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
%%  ʱ����
figure(1);
subplot(3, 1, 1);
plot(t, s, 'r', 'LineWidth', 1.2);
axis([1500/Fs, 1600/Fs, 0, 1]);
title('�˲�ǰʱ����');
subplot(3, 1, 2);
plot(t,s_addnoise,'r','LineWidth',1.2);
axis([1500/Fs, 1600/Fs, 0, 1]);
title('��������ʱ����');
subplot(3, 1, 3);
plot(t, y, 'r', 'LineWidth',1.2);
axis([1500/Fs, 1600/Fs, 0,1]);
title('����Ӧ�˲���ʱ����');
%% �������
figure(2);
plot(abs(e), 'r', 'LineWidth', 1.2);
title('�������');