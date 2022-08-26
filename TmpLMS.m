%% ���ԭ�����ݱ�������ͼ��
clear, clc, close all;

%% �ź���������
fs = 1000;                              %����Ƶ��
t = 0 : 1 / fs : 1 - 1 / fs;            %ʱ����
N = length(t);                          %��������
% [x, xn] = wnoise(2, 10, 6);             %����������������
x = 10 * cos(2 * pi * 50 * t + 45) + 4 * sin(2 * pi * 100 * t + 135);
xn = 5 * randn(1, N);
s = x + xn;

%% ��������Ӧ�˲�����
M = 100;                                 %�˲����Ľ���
mu = 0.00004;                           %��������
[e, w, y] = LMSFun(mu, M, s', x');     %LMSģ��
figure(1);
subplot(3, 1, 1);
plot(x, 'r');
title('�˲�ǰʱ����');
subplot(3, 1, 2);
plot(s,'r');
title('��������ʱ����');
subplot(3, 1, 3);
plot(y, 'r');
title('����Ӧ�˲���ʱ����');
%% �������
% figure(2);
% plot(abs(e), 'r');
% title('�������');

%% �������ܣ������
snrxn  = mySNR(x, s);                  %ԭ���������
snrlms = mySNR(x, y);                   %LMS����������
snr1 = sprintf("δ����ʱ�����: %g", snrxn)
snr2 = sprintf("LMS�����������: %g", snrlms)

%% �������ܣ����������
REMSEn = myREMSE(x, s, N);             %ԭ�����ź�
REMSEl = myREMSE(x, y,  N);             %LMS�����
REMSE1 = sprintf("δ����ʱREMSE: %g", REMSEn)
REMSE2 = sprintf("LMS�����REMSE: %g", REMSEl)