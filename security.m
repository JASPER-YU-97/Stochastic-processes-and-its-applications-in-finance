% CF = [-100; 100; 100];
r = 0.1;
t = 10;
NPV = pvvar(CF,r);
IRR = irr(CF);
C = [1000, 1000, 1000];
bondprice(C, 1000, 0.1);
pp = PVA(10, 100, 0.1);
% n = annuterm(r,100, 6.144567105704680e+02, 0, 0);
% durationծȯ�ľ��ڣ����ն�������sensitivity to interest rate change
% durationԽ�����ֽ��������ʱ䶯����Խ��(Խ����)
[D, Dmod] = cfdur(C, r);
% ͹��convexity���ֽ��������ʱ䶯�Ķ��׹��ƣ�����Taylorչ��
% ͹���Ƕ�duration��Ϊ����ָ��ķ�����������
cv = cfconv(C, r);

