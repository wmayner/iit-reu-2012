function [ c ] = findWeights( data, kernel )
%FINDWEIGHTS Takes a distance matrix, a kernel, and an epsilon, and solves
%the linear system Kc = y to find weights, and then returns the
% resulting function.
%   Note: the kernel must take matrix-valued arguments.

x = data(:,1);
y = data(:,2);

[N,trash] = size(x);
clear trash

for i = 1:N
    for j = 1:N
        K(i,j) = kernel(x(i),x(j));
    end
end

disp(['Condition number of K = ',int2str(cond(K))]);

c = linsolve(K,y);

end