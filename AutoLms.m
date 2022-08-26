clc,clear,close all;
g=100;
L=1024;%�źų���
k=128;%�˲�������
pp=zeros(g,L-k);
u=0.001;
for q=1:g
    t=1:L;
    a=1;
    s=a*sin(0.05*pi*t);
    figure(1);
    subplot(311);
    plot(s);
    title('�ź�sʱ����');
    xlabel('n');
    axis([0,L,-a-1,a+1]);
    xn=awgn(s,5);               %�����5dB��WGN
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
title('�źżӸ�˹���������ʱ����');
axis([0,L,-a-2,a+2]);
subplot(313)
plot(y);
axis([0,L,-a-1,a+1]);
title('LMS�㷨����Ӧ�˲�������ʱ����');