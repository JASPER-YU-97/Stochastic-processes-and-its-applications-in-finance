function [V, volV] = KMVsol(E,D ,r, T, volE)
m = E./D;% m是KMVfun的输入项。方便调用KMVfun。1+m = V/D = (E + D)/D
x0 = [1, 1]; % 向量，x0初始值
solution = fsolve(@(x) KMVfun(m, r, T, volE, x), x0);% 存储解，第一个数是x1，第二个是x2.
volV = solution(2);
V = E*solution(1); %因为x1是V/E。
end


