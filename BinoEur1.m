function [c1,p1] = BinoEur1(S0,X,r,T,sig,N)
dt = T/N;
u = exp(sig * sqrt(dt));
d = 1/u;
q = (exp(r * dt) - d)/(u - d);

S = zeros(N+1,1);
% ������ĳ�����������ֻ����һ��S���۸����������ĵ�N��S�۸�u^N*SO, u^(N-1)*d*SO

%% ���ڱ���ʲ��۸�����Ƴ�ŷʽ������Ȩ
% ���ĵ�N�ڵĿ�����Ȩ��ֵ
for i = 1:N+1
    S(i)=max(u^(N-i+1).*d.^(i-1).*S0 - X, 0);
end

% �����һ����ǰ�ƣ���Ϊû�о������Ի�������������������������Ľڵ��Ǻ�һ�ڶ�����������֧������ֵ��
% ���Ƴ�����ǰһ���ڵ��ֵ�����Ƕ�Ӧ��λ�ã�Ȼ�󲻶ϵ�������ǰ�ƣ���Ҫ����ѭ����һ���Ƕ��ڸ��ǣ�һ���Ǵ�N��0����ǰ����(����ѭ��)��
% ���ڵ�N�ڣ��ܹ���N+1��ֵ(����)����N��N+1�ĸ���Ҫ����N�Σ�N-1�ڣ�������N��ֵ������N-1�Σ�
% һֱ����1�ڣ�����һ�ξ������ܹ��õ�S0��
% ����֮�䣬N->1���ڲ�ѭ��(����)�����д���N->.ͬʱ�ڲ����д���ȡ��������ƽ�����������

for j=N:-1:1 %�Ӻ���ǰ�ƣ���N��1�����Ϊ-1.���ѭ���Ĵ������ϱ��٣�ֱ����0��
    for i=1:j %�ڲ�ѭ����ÿ�����ѭ���ƽ�һ�Σ��ڲ��1��N��Ҫ������1��j�ĸ���һ�Σ�j֮����������ֲ���Ҫ���ǡ�
        S(i)=exp(-r*dt).*(q.*S(i)+(1-q).*S(i+1));
    end
end
% �õ���Ȩ����������(1,1)����Ȩtʱ������������ֵ��Ҳ������Ȩ�ļ۸�
%% ȡ����һ�е�����Ϊ��Ȩ�۸�
c1 = S(1);
%% ŷʽ����

% ���ĵ�N�ڵĿ�����Ȩ��ֵ
for i = 1:N+1
    S(i)=max(X - u^(N-i+1).*d.^(i-1).*S0, 0);
end

% �����һ����ǰ��
for j=N:-1:1 %�Ӻ���ǰ�ƣ���N��1�����Ϊ-1.���ѭ���Ĵ������ϱ��٣�ֱ����0��
    for i=1:j %�ڲ�ѭ����ÿ�����ѭ���ƽ�һ�Σ��ڲ��1��N��Ҫ������1��j�ĸ���һ�Σ�j֮����������ֲ���Ҫ���ǡ�
        S(i)=exp(-r*dt).*(q.*S(i)+(1-q).*S(i+1));
    end
end
%% ȡ����һ�е�����Ϊ��Ȩ�۸�
p1 = S(1);
end