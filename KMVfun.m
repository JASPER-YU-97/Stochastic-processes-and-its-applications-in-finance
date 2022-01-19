function F = KMVfun(m, r, T, volE, x)
% F当中是两个数值,因为下面对应的是两个方程。
d1 = (log(x(1).*m)+(r+0.5.*x(2).^2).*T)./(x(2).*sqrt(T));
d2 = d1-x(2).*sqrt(T);
F = [x(1).*normcdf(d1)-1./m.*exp(-r.*T).*normcdf(d2)-1;...
    normcdf(d1).*x(1).*x(2)-volE];
end