function V = bondprice(C,M,k)
n=length(C);
V=0;
C(n)=C(n)+M;
for i=1:n
    V=V+C(i)./(1+k).^i;
end
end

