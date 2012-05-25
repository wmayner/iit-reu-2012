function [ c ] = findWeights( data, kernel, epsilon )
%MAKEAPPROXFUNC Takes a kernel and data (a function of two variables and a
%N x 2 matrix, respectively, where the first column is the point of
%measurement and the second is the measurement.) and returns an
%approximation function s.
%   Solves the linear system Kc = y to find weights, and then returns the
%   resulting function.
%   Note: the kernel must take matrix-valued arguments.

x = data(:,1);
y = data(:,2);

[n,one] = size(x);

K = zeros(n);

%TODO only fill triangle, not whole matrix
%TODO vectorize dis shit
for i = 1:n
    for j = i:n
        K(i,j) = kernel(x(i),x(j));
    end
end

disp(['Condition number of K = ',int2str(cond(K))]);

c = linsolve(K,y);

end