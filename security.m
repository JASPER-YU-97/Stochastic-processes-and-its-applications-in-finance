% CF = [-100; 100; 100];
r = 0.1;
t = 10;
NPV = pvvar(CF,r);
IRR = irr(CF);
C = [1000, 1000, 1000];
bondprice(C, 1000, 0.1);
pp = PVA(10, 100, 0.1);
% n = annuterm(r,100, 6.144567105704680e+02, 0, 0);
% duration债券的久期（风险度量）：sensitivity to interest rate change
% duration越长，现金流对利率变动幅度越大(越敏感)
[D, Dmod] = cfdur(C, r);
% 凸性convexity是现金流对利率变动的二阶估计，基于Taylor展开
% 凸性是对duration作为线性指标的非线性修正。
cv = cfconv(C, r);

