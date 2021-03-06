function [t,st]=Stock_est(s0,mu,sigma,Lt)
%------------------------------------------------------ 初始设置------------------------------------------------------ %
t=0:0.1:Lt;
t=t';
x=0;
w=[x];
%------------------------------------------------------ 生成维纳过程------------------------------------------------------ %
for s=0.1:0.1:Lt;
dw=0+0.1.*rand(1,1);
x=x+dw;
w=[w x];
end
w=w';
%------------------------------------------------------ 生成股票过程------------------------------------------------------ %
st=s0*exp(sigma*w+(mu-(1/2)*(sigma)^2)*t);
plot(t,st)
end