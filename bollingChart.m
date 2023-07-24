%% 常用指标的计算
clc, clear, close all
load('sh600000.mat')
CP = fliplr(P(1:600,5)')'; % 提取收盘价时间序列
Dates =fliplr(P(1:600,1)')'; % 提取日期
%% 布林曲线
[Movavgv, UpperBand, LowerBand] = bolling(CP, 20);
figure, plot(Dates(20:600,:), [CP(20:600,:),Movavgv, UpperBand, LowerBand]), grid on
legend('Price','Movavgv','UpperBand',' LowerBand','Location','Best')
datetick('x', 'mmm-yy')

%% 布林线策略
N =  size(CP(20:600,:));
s = ones(N);
for i = 2:N
    if s(i)==1 && CP(19+i-1)<UpperBand(i-1) && CP(19+i)> UpperBand(i)
        s(i)=1;
        s(i+1:end)=0;
    elseif s(i)==0 && CP(19+i-1)>LowerBand(i-1) && CP(19+i)<LowerBand(i)
        s(i)=-1;
         s(i+1:end)=1;
    end
end
r = [0; s(2:end).*diff(CP(20:600,:))];
plot(Dates(20:600,:), cumsum(r));
datetick('x', 'mmm-yy');

