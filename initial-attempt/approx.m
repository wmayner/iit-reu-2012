function [output] = approx(input,kernel,data,c)
%APPROX Takes a (real-valued) scalar input, a column vector of weights, and a
%kernel function, and returns the approximation.
%   Note: The kernel must take matrix-valued input.

domain = data(:,1);

    terms = c.*kernel(input,domain);
    output = sum(terms);
    
end