%% 读取数据
data = xlsread('TS.xlsx',2,'A1:D16');
%% 循环计算vol和V
% Vm = [];
% volVm = [];
for i = 1:16
    r = data(i,4); %无风险利率
    T = 0.25; %时间一个季度
    D = data(i,1); %债务数
    E = data(i,2); %所有者权益
    volE = data(i,3); %股权波动率
    [V, volV] = KMVsol(E, D, r, T, volE);
    data(i, 5) = V;
    data(i, 6) = volV;
%     Vm = [Vm,V];
%     volVm = [volVm,volV];
end

%% 循环计算DD和EDF
for i = 1:16
    r = data(i,4); %无风险利率
    D = data(i,1); %债务数
    volE = data(i,3); %股权波动率
    V = data(i, 5);
    volV = data(i, 6);
    DD = (log(V/D)+(r-0.5.*volV.^2).*T)/(volV.*sqrt(T));
    EDF = normcdf(-DD); % 违约概率
    data(i, 7) = DD;
    data(i, 8) = EDF;
end