epsilon = 1;

kernel = @(x,y) exp((-epsilon^2).*abs(x-y).^2); % Gaussian

samples = (0:0.1:1)';
data = exp(samples);
[n,one] = size(samples);

testData = [samples,data];

c = findWeights(testData, kernel, epsilon);

for i = 1:n
    testApprox(i) = approx(samples(i), kernel, testData,c);
end

testApprox = testApprox';

err = abs(data - testApprox)