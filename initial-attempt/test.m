clear

N = 9; gridtype = 'h';
epsilon = 40;

kernel = @(x,y) exp(-(epsilon*sqrt((x-y).^2).^2)); % Gaussian kernel

% Load data
name = sprintf('Data1D_%d%s',N,gridtype); load(name)
neval = 40; grid = linspace(0,1,neval);

% Franke's test function (1D):
f1 = @(x,y) 0.75*exp(-((9*x-2).^2+(9*y-2).^2/4));
f2 = @(x,y) 0.75*exp(-((9*x+1).^2+(9*y+1).^2/10));
f3 = @(x,y) 0.5*exp(-((9*x-7).^2+(9*y-3).^2/4));
f4 = @(x,y) 0.2*exp(-((9*x-4).^2+(9*y-7).^2));
testfunction = @(x) f1(x,1)+f2(x,1)+f3(x,1)+f4(x,1);

data = testfunction(dsites(:,1));

[n,trash] = size(data);
clear trash

testData = [dsites,data]

c = findWeights(testData, kernel);

testApprox = zeros(n,1);
for i = 1:n
    testApprox(i) = approx(dsites(i), kernel, testData,c);
end

err = abs(data - testApprox)