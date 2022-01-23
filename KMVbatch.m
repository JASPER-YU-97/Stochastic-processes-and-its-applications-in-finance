%% ��ȡ����
data = xlsread('TS.xlsx',2,'A1:D16');
%% ѭ������vol��V
% Vm = [];
% volVm = [];
for i = 1:16
    r = data(i,4); %�޷�������
    T = 0.25; %ʱ��һ������
    D = data(i,1); %ծ����
    E = data(i,2); %������Ȩ��
    volE = data(i,3); %��Ȩ������
    [V, volV] = KMVsol(E, D, r, T, volE);
    data(i, 5) = V;
    data(i, 6) = volV;
%     Vm = [Vm,V];
%     volVm = [volVm,volV];
end

%% ѭ������DD��EDF
for i = 1:16
    r = data(i,4); %�޷�������
    D = data(i,1); %ծ����
    volE = data(i,3); %��Ȩ������
    V = data(i, 5);
    volV = data(i, 6);
    DD = (log(V/D)+(r-0.5.*volV.^2).*T)/(volV.*sqrt(T));
    EDF = normcdf(-DD); % ΥԼ����
    data(i, 7) = DD;
    data(i, 8) = EDF;
end