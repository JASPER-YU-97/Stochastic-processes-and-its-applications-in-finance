% options的本质是选择权
% premium是期权费/权利金:权利的价格、期权的价格
% stricke price敲定价格/履约价格、exercise price执行价格：买入与卖出标的物的合同价
% call看涨，买权/put看跌，卖权
% Euro options欧式:到期日/American options美式;签订日到到期日之间(更灵活)
% 期货期权(on Futures):期货合约为标的物：金融期货、商品期货；
% 现货合约(physical options)：现货商品或金融工具为标的物：股票，股指，货币，债券
% S标的市价，X协定价格(合同价)，r无风险利率,T有效期，波动率sigma，标的资产收益率D
% BSM模型欧式现货，black模型欧式期货。
S = 110;
r = 0.1;
X = 90;
T = 2;
sig = 0.5;
D = 0.05;
F = 500;
FX = 505;% F:futures
[C, P] = blsprice(S ,X,r,T, sig, D);%BSM模型
[c1, p1] = blkprice(F, FX, r, T, sig);%black模型
% 二项式模型CRR，模型当中考虑到n，表达式类似于二项分布和value function的期望值，得到的解是数值解，而BSM的解是解析解。
% 解析解给出的是准确解，但是数值解需要通过提高n的大小(总次数)来提高解的准确性。大n->电脑计算时间长。
% BSM只能对欧式期权做解，但CRR可以对更加广的期权做解:美式，欧式，奇异：Barrier,aisan,cash/capital-or-nothing Options
% dt = 0.01;% T = n * dt, n = 200
% Flag = 0; %flag = 0是看跌，1是看涨
% [asset, option] = binprice(S,X, r, T, dt, sig, Flag);% DividendRate, Dividend, ExDiv可选
% 强制使binprice只能用于美式期权的计算，实际上二项式模型也可以算欧式，在n做够大的前提下和BSM的解一致。
% asset和option分别输出的是标的资产的和期权的价格状态，基于二叉树形成n * n的矩阵，上三角矩阵，下方全为0，上方为数值
% 结果中option矩阵的第1行第1列的值就是期权的价值。

% 因为期权价格和S,X,r,t和sigma相关
% 所以希腊字母实际上研究是是这5个变化对最后期权价格的影响，量化影响->求偏导
% delta = df/dS; gamma = df^2/dS^2 = dDelta/dS;
% rho = df/dr; vega(Kappa) = df/dSigma;
% theta = df/dt; Lambda = (df/f)/(dS/S)
% Pi代表总的revenue，Alpha代表无风险的revenue，也代表“excess return” or “abnormal rate of return,”

testS = 0.1:.1:100;
testX = 50;
[CD, PD] = blsdelta(testS, testX,r,T,sig);
plot(testS, PD)
% 图像取值是在0到1之间(看涨期权delta取值在0到1之间，看跌期权取值在-1到0之间)，S与CD/PD的delta之间是通向变化关系。

% 隐含波动率implied
% volatility是将模型中除波动率之外的所有因素带入模型，反求出的波动率，隐含波动率往往无法得到解析解，需要通过数值解。
% 基于BSM模型，所以计算的是欧式期权，因为是通过数值解，所以是通过迭代逼近的方式求解，需要设上限Limit
% Tolerance设置求解的精确度，默认为精确到10^-6。
% Class是期权的类型，看涨是true或者{'call'}，看跌是false或{'put'}。
Vol = blsimpv(testS, testX,r,T,sig, 20);
plot(testS, Vol)% 整体上是反向，S增加波动率下降