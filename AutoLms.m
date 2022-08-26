clc,clear,close all;
g=100;
L=1024;%信号长度
k=128;%滤波器阶数
pp=zeros(g,L-k);
u=0.001;
for q=1:g
    t=1:L;
    a=1;
    s=a*sin(0.05*pi*t);
    figure(1);
    subplot(311);
    plot(s);
    title('信号s时域波形');
    xlabel('n');
    axis([0,L,-a-1,a+1]);
    xn=awgn(s,5);               %信噪比5dB的WGN
    y=zeros(1,L);
    y(1:k)=xn(1:k);
    w=zeros(1,k);
    e=zeros(1,L);
    for i=(k+1):L
        XN=xn((i-k+1):(i));
        y(i)=w*XN';
        e(i)=s(i)-y(i);
        pp(i)=pp(i)+e(i);
        w=w+u*e(i)*XN;
    end
end
subplot(312)
plot(xn);
title('信号加高斯白噪声后的时域波形');
axis([0,L,-a-2,a+2]);
subplot(313)
plot(y);
axis([0,L,-a-1,a+1]);
title('LMS算法自适应滤波后的输出时域波形');