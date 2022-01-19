function V = PVA(n, CF, k)
V = 0;
for i=1:n
    V=V+CF./(1+k).^i;
end
end