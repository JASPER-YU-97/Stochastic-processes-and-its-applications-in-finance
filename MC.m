% 通过蒙特卡洛模拟来生成多组ST的可能价格，根据期权的性质计算对应的payoff
% call:max(ST - X, 0); put;max(X - ST, 0).计算payoff的平均值，再贴现，得到期权价格。

%%
S0 = 100;
X = 100;
r = 0.05;
T = 1;
sig = 0.5;
N = 1000000;
ST = zeros(1,N);
VC = zeros(1,N);
VP = zeros(1,N);
%%
for i = 1:N
    ST(i)=S0.*exp((r-0.5.*sig^2).*T+sig.*sqrt(T).*randn);
end

% call看涨期权
VC = max(ST - X, 0);
Vc = mean(VT).*exp(-r.*T);

% put看跌期权
VP = max(X - ST, 0);
Vp = mean(VP).*exp(-r.*T);
%% 验证
yz = blsprice(S0,X,r,T,sig);
yz1 = blsprice(S0,X,r,T,sig,1);
% 随着n的增加，结果越来越接近BS模型的结果，但是随着N的增加，计算的时间也增加。
% MC提供的是全新的计算option价格的方式(通过的是模拟标的物价格)，不同于二项式和BS模型，Monte Carlo的方法得到的结果具有一定的随机性。
% 但是基于大数定理，当n无限大时模拟的结果会和公式计算的一致，并且固定为1个值，随机性去除。
% 而且蒙地卡罗在计算奇异期权价值上也有作用，因为在欧式期权上，所以直接通过公式从S0得到ST的值，
% 但是如果是美式，需要对ST的值离散化，构造出每一个小时间段相应标的资产的可能价格(不是向量)，所以需要的应该是一个矩阵(计算复杂)。
