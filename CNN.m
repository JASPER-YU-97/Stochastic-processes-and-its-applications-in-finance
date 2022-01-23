%%
stock=xlsread('stock60000.xlsx');%%��������
[n,m]=size(stock);
Time = (1:n);%%ʱ������
CLOSE =stock(:,5)';%%��������
figure(1)%%�ɼ���ͼ
plot(Time,CLOSE,'linewidth',1.5);
grid on;
h=legend('���̼�');
set(h,'location','SouthEast');
title('���̼�');
xlabel('ʱ�����');ylabel('���̼�');

%%
num = 1;
endNum = 50;%��ֹ��end-endNum����Ϊ����
no_use = 0;%���no_use������
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
net1=newrb(P,T,spread);%%RBF���� 
%% BP
net2 = newff(P,T,[5,4],{'tansig','tansig','purelin'},'traingdm');% 0.00179
%% ѵ������
net2.trainParam.epochs =50000;% ���ѵ�����ٴ�
net2.trainParam.goal = 0.002;% ѵ����ʲô�̶Ȳ���ɹ�
%% ��ʼѵ��
[net2,tr] = train(net2,P,T); %�˴���xlsread�������Ķ�excel�ļ�
ptest=zeros(endNum,5);
ttest=zeros(endNum,1);
for j=1:endNum-no_use;
ptest(j,:)=[X2(n-endNum+j-4);X2(n-endNum+j+1-4);X2(n-endNum+j+2-4);X2(n-endNum+j+3-4);X2(n-endNum+j+4-4) ];
end
Ptest=ptest';
Ttest=CLOSE (n-endNum+2:n-no_use); 
%% RBF ���� 
result1=sim(net1,Ptest);
Result1=result1*(a(2)-a(1))+a(1)
%% BP ����
result2=sim(net2,Ptest);
Result2=result2*(a(2)-a(1))+a(1)
%% ������
err1=Result1(1:endNum-1)-Ttest;%RBF ������
err2=Result2(1:endNum-1)-Ttest;%BP ������

%% ��ͼ
figure(2)
plot(Time(n-endNum+1:n-no_use-1),Ttest,'r:O',Time(n-endNum+1:n-no_use-1),Result1(1:endNum-1),'b:*',Time(n-endNum+1:n-no_use-1),Result2(1:endNum-1),'g-x');
legend('��ʵֵ','RBFԤ��ֵ','BPԤ��ֵ')
xlabel('ʱ������')
ylabel('�ɼ�')
figure (3)
plot(Time(n-endNum+1:n-no_use-1),err1,'b:*',Time(n-endNum+1:n-no_use-1),err2,'g-x')
legend('RBF���','BP���')
xlabel('ʱ������')
ylabel('���')