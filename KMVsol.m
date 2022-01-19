function [V, volV] = KMVsol(E,D ,r, T, volE)
m = E./D;% m��KMVfun��������������KMVfun��1+m = V/D = (E + D)/D
x0 = [1, 1]; % ������x0��ʼֵ
solution = fsolve(@(x) KMVfun(m, r, T, volE, x), x0);% �洢�⣬��һ������x1���ڶ�����x2.
volV = solution(2);
V = E*solution(1); %��Ϊx1��V/E��
end


