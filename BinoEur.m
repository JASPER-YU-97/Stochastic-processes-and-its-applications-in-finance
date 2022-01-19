function [S,C,P,c1,p1] = BinoEur(S0,X,r,T,sig,N)
dt = T/N;
u = exp(sig * sqrt(dt));
d = 1/u;
q = (exp(r * dt) - d)/(u - d);

S = zeros(N+1, N+1);
P = zeros(N+1, N+1);
C = zeros(N+1, N+1);
% 因为MATLAB是矩阵运算，所以要把二叉树改造成矩阵(上三角)；S0 ->S11/S12-> S21/S22/S23.
% 目的是从S0推出整个二叉树矩阵，简化出上涨就是u*S,下跌就是d*S: S0 ->uS0/dS0-> u^2*S0/udS0/d^2*S0.
% 从矩阵中提取出相同的乘数，第一行提取出d^0 = 1,第二行d^1，第三行d^2。d^i-1在第i行。
% 从列中可以提取u, 但列的数值是u^2->u^1->u^0,
% 所以第i行，第j列的数值：d^(i-1)*u^(j-1-(i-1))* SO = u^(j-i)*d^(i-1) *SO.并且 i<=j.

for i=1:N+1
    for j=i:N+1
        S(i,j)=u.^(j-i).*d.^(i-1).*S0;
    end
end
%% 基于标的资产价格矩阵推出欧式看涨期权
for i = 1:N+1
    C(i,N+1)=max(S(i,N+1)-X, 0);
end

% 从最后一期往前推
for j=N:-1:1 %从后往前推，从N到1，间隔为-1.
    for i=1:j
        C(i,j)=exp(-r*dt).*(q.*C(i,j+1)+(1-q).*C(i+1,j+1));
    end
end
% 得到期权二叉树矩阵，(1,1)是期权t时点期望的贴现值，也就是期权的价格。

%% 欧式看跌

for i = 1:N+1
    P(i,N+1)=max(X-S(i,N+1), 0);
end

% 从最后一期往前推
for j=N:-1:1 %从后往前推，从N到1，间隔为-1.
    for i=1:j
        P(i,j)=exp(-r*dt).*(q.*P(i,j+1)+(1-q).*P(i+1,j+1));
    end
end
%% 取出第一行第一列的数作为期权价格
c1 = C(1,1);
p1 = P(1,1);
end