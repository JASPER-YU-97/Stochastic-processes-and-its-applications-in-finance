%%
stock=xlsread('stock60000.xlsx');%%导入数据
[n,m]=size(stock);
Time = (1:n);%%时间序列
CLOSE =stock(:,5)';%%收盘序列
figure(1)%%股价作图
plot(Time,CLOSE,'linewidth',1.5);
grid on;
h=legend('收盘价');
set(h,'location','SouthEast');
title('收盘价');
xlabel('时间序号');ylabel('收盘价');

%%
num = 1;
endNum = 50;%截止到end-endNum，作为测试
no_use = 0;%最后no_use个不用
a=minmax(CLOSE);
X2=(CLOSE-a(1))/(a(2)-a(1));
p=zeros(n-endNum,5);
t=zeros(n-endNum,1);
for i=1:1:(n-endNum)
p(i,:)=[X2(i);X2(i+1);X2(i+2);X2(i+3);X2(i+4) ];
t(i)=X2(i+5);
end
P=p';
T=t'; 
%%
spread=30;
net1=newrb(P,T,spread);%%RBF网络 
%% BP
net2 = newff(P,T,[5,4],{'tansig','tansig','purelin'},'traingdm');% 0.00179
%% 训练参数
net2.trainParam.epochs =50000;% 最多训练多少次
net2.trainParam.goal = 0.002;% 训练到什么程度才算成功
%% 开始训练
[net2,tr] = train(net2,P,T); %此处用xlsread函数来阅读excel文件
ptest=zeros(endNum,5);
ttest=zeros(endNum,1);
for j=1:endNum-no_use;
ptest(j,:)=[X2(n-endNum+j-4);X2(n-endNum+j+1-4);X2(n-endNum+j+2-4);X2(n-endNum+j+3-4);X2(n-endNum+j+4-4) ];
end
Ptest=ptest';
Ttest=CLOSE (n-endNum+2:n-no_use); 
%% RBF 测试 
result1=sim(net1,Ptest);
Result1=result1*(a(2)-a(1))+a(1)
%% BP 测试
result2=sim(net2,Ptest);
Result2=result2*(a(2)-a(1))+a(1)
%% 误差分析
err1=Result1(1:endNum-1)-Ttest;%RBF 误差分析
err2=Result2(1:endNum-1)-Ttest;%BP 误差分析

%% 绘图
figure(2)
plot(Time(n-endNum+1:n-no_use-1),Ttest,'r:O',Time(n-endNum+1:n-no_use-1),Result1(1:endNum-1),'b:*',Time(n-endNum+1:n-no_use-1),Result2(1:endNum-1),'g-x');
legend('真实值','RBF预测值','BP预测值')
xlabel('时间序列')
ylabel('股价')
figure (3)
plot(Time(n-endNum+1:n-no_use-1),err1,'b:*',Time(n-endNum+1:n-no_use-1),err2,'g-x')
legend('RBF误差','BP误差')
xlabel('时间序列')
ylabel('误差')