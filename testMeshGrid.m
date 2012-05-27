% Tests s-dimensional RBF interpolation with Franke's test function.
%   Calls on: makeRBFApprox

N = 9; gridtype = 'h'; % N = number of data points

epsilon = 21; % Shape parameter

% Define RBF (in terms of epsilon and radius)
rbf = @(e,r) exp(-(e*r).^2);

% Load data
name = sprintf('Data1D_%d%s',N,gridtype); load(name)
neval = 40;
grid = linspace(0,1,neval);

% Make a mesh on which to evaluate the interpolant and exact function
    [xe,ye] = meshgrid(grid);
    epoints = [xe(:) ye(:)]