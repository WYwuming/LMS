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