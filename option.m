% options�ı�����ѡ��Ȩ
% premium����Ȩ��/Ȩ����:Ȩ���ļ۸���Ȩ�ļ۸�
% stricke price�ö��۸�/��Լ�۸�exercise priceִ�м۸����������������ĺ�ͬ��
% call���ǣ���Ȩ/put��������Ȩ
% Euro optionsŷʽ:������/American options��ʽ;ǩ���յ�������֮��(�����)
% �ڻ���Ȩ(on Futures):�ڻ���ԼΪ���������ڻ�����Ʒ�ڻ���
% �ֻ���Լ(physical options)���ֻ���Ʒ����ڹ���Ϊ������Ʊ����ָ�����ң�ծȯ
% S����мۣ�XЭ���۸�(��ͬ��)��r�޷�������,T��Ч�ڣ�������sigma������ʲ�������D
% BSMģ��ŷʽ�ֻ���blackģ��ŷʽ�ڻ���
S = 110;
r = 0.1;
X = 90;
T = 2;
sig = 0.5;
D = 0.05;
F = 500;
FX = 505;% F:futures
[C, P] = blsprice(S ,X,r,T, sig, D);%BSMģ��
[c1, p1] = blkprice(F, FX, r, T, sig);%blackģ��
% ����ʽģ��CRR��ģ�͵��п��ǵ�n�����ʽ�����ڶ���ֲ���value function������ֵ���õ��Ľ�����ֵ�⣬��BSM�Ľ��ǽ����⡣
% �������������׼ȷ�⣬������ֵ����Ҫͨ�����n�Ĵ�С(�ܴ���)����߽��׼ȷ�ԡ���n->���Լ���ʱ�䳤��
% BSMֻ�ܶ�ŷʽ��Ȩ���⣬��CRR���ԶԸ��ӹ����Ȩ����:��ʽ��ŷʽ�����죺Barrier,aisan,cash/capital-or-nothing Options
% dt = 0.01;% T = n * dt, n = 200
% Flag = 0; %flag = 0�ǿ�����1�ǿ���
% [asset, option] = binprice(S,X, r, T, dt, sig, Flag);% DividendRate, Dividend, ExDiv��ѡ
% ǿ��ʹbinpriceֻ��������ʽ��Ȩ�ļ��㣬ʵ���϶���ʽģ��Ҳ������ŷʽ����n�������ǰ���º�BSM�Ľ�һ�¡�
% asset��option�ֱ�������Ǳ���ʲ��ĺ���Ȩ�ļ۸�״̬�����ڶ������γ�n * n�ľ��������Ǿ����·�ȫΪ0���Ϸ�Ϊ��ֵ
% �����option����ĵ�1�е�1�е�ֵ������Ȩ�ļ�ֵ��

% ��Ϊ��Ȩ�۸��S,X,r,t��sigma���
% ����ϣ����ĸʵ�����о�������5���仯�������Ȩ�۸��Ӱ�죬����Ӱ��->��ƫ��
% delta = df/dS; gamma = df^2/dS^2 = dDelta/dS;
% rho = df/dr; vega(Kappa) = df/dSigma;
% theta = df/dt; Lambda = (df/f)/(dS/S)
% Pi�����ܵ�revenue��Alpha�����޷��յ�revenue��Ҳ����excess return�� or ��abnormal rate of return,��

testS = 0.1:.1:100;
testX = 50;
[CD, PD] = blsdelta(testS, testX,r,T,sig);
plot(testS, PD)
% ͼ��ȡֵ����0��1֮��(������Ȩdeltaȡֵ��0��1֮�䣬������Ȩȡֵ��-1��0֮��)��S��CD/PD��delta֮����ͨ��仯��ϵ��

% ����������implied
% volatility�ǽ�ģ���г�������֮����������ش���ģ�ͣ�������Ĳ����ʣ����������������޷��õ������⣬��Ҫͨ����ֵ�⡣
% ����BSMģ�ͣ����Լ������ŷʽ��Ȩ����Ϊ��ͨ����ֵ�⣬������ͨ�������ƽ��ķ�ʽ��⣬��Ҫ������Limit
% Tolerance�������ľ�ȷ�ȣ�Ĭ��Ϊ��ȷ��10^-6��
% Class����Ȩ�����ͣ�������true����{'call'}��������false��{'put'}��
Vol = blsimpv(testS, testX,r,T,sig, 20);
plot(testS, Vol)% �������Ƿ���S���Ӳ������½�