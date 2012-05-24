function [ s ] = makeApproxFunc( kernel, data )
%MAKEAPPROXFUNC Takes a kernel and data (a function of two variables and a
%N x 2 matrix, respectively, where the first column is the point of
%measurement and the second is the measurement.) and returns an
%approximation function s.
%   Solves the linear system Kc = y to find weights, and then returns the
%   resulting function.
%   Note: the kernel must take matrix-valued arguments.



end