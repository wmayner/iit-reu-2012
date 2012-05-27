function s = makeRBFApprox( rbf, epsilon, testfunction, dsites, ctrs )
%RBFINTERP Makes an RBF interpolation function with the specified kernel, 
%shape parameter, and testfunction. Evaluates the test function at each of 
%the dsites and centers the RBFs at the ctrs.
%   rbf must be a function of 2 variables: the (scalar) shape parameter and a
%   distance matrix.
%   testfunction must take a row vector x.
%   Calls on: makeDistanceMatrix

% Evaluate the testfunction at the data sites
[N,s] = size(dsites);
b = zeros(N,1);
for i = 1:N
    b(i) = testfunction(dsites(i,:));
end

% Generate the distance matrix
DM = makeDistanceMatrix(dsites,ctrs);

% Generate the kernel matrix K from the distance matrix
K = rbf(epsilon,DM);
disp(['cond(K) = ',num2str(cond(K))]);

% Solve the linear system Kc = y to find the weights c
c = linsolve(K,b);

% Generate the approximation function s
%   s(x) = sum_{k=1}^N  c_k * rbf(|| x - x_k ||_2)
    function [approx] = rbfApprox(x)
        % The function is in an s-dimensional space
        [one,s] = size(x);
        
        % Make an N x s matrix where each row is the input vector x
        Nx = ndgrid(x,1:N)';
        
        % Accumulate the distances || x - x_k ||_2 into distance vector DV
        DV = zeros(N,1);
        for d = 1:s
            DV = DV + (Nx(:,d) - dsites(:,d)).^2;
        end
        DV = sqrt(DV);
        % Generate the terms: c_k * rbf( ||x - x_k||_2
        terms = c.*rbf(epsilon,DV);
        approx = sum(terms);
    end
s = @rbfApprox;

end

