% Tests d-dimensional RBF interpolation with Franke's test function.
%   Calls on: makeRBFApprox

dimension = 2;

N = 1089; gridtype = 'h'; % N = number of data points

epsilon = 21.1; % Shape parameter

% Define RBF (in terms of epsilon and radius)
rbf = @(e,r) exp(-(e*r).^2);

% Load data
name = sprintf('Data%dD_%d%s',dimension,N,gridtype); load(name)
neval = 40;
grid = linspace(0,1,neval);

% Franke's test function (2D):
f1 = @(x,y) 0.75*exp(-((9*x-2).^2+(9*y-2).^2/4));
f2 = @(x,y) 0.75*exp(-((9*x+1).^2+(9*y+1).^2/10));
f3 = @(x,y) 0.5*exp(-((9*x-7).^2+(9*y-3).^2/4));
f4 = @(x,y) 0.2*exp(-((9*x-4).^2+(9*y-7).^2));
testfunction = @(x) f1(x(1),x(2))+f2(x(1),x(2))+f3(x(1),x(2))+f4(x(1),x(2));

ctrs = dsites; % Center the RBF at the data sites

% Generate interpolant function
s = makeRBFApprox(rbf, epsilon, testfunction, dsites, ctrs);

% Compare interpolant to exact result:
% Make a mesh on which to evaluate the interpolant and exact function
[xe,ye] = meshgrid(grid);
epoints = [xe(:) ye(:)];
[numEPoints,two] = size(epoints);
% Compute distance matrix between evaluation points and centers
DM_eval = makeDistanceMatrix(epoints,ctrs);
% Compute interpolant P_f at evaluation points
Pf = zeros(numEPoints,1);
for i = 1:numEPoints
    Pf(i) = s(epoints(i,:));
end
% Compute exact solution, i.e., evaluate test function on evaluation
% points
exact = testfunction(epoints);
% Compute errors on evaluation grid
maxerr = norm(Pf-exact,inf);
rms_err = norm(Pf-exact)/neval;
fprintf('RMS error:     %e\n', rms_err)
fprintf('Maximum error: %e\n', maxerr)
% Plot interpolant
fview = [160,20]; % for Franke's function
caption = ['RBF interpolant ',...
    'false colored by maximum error.'];
PlotSurf(xe,ye,Pf,neval,exact,maxerr,fview,caption);
% Plot maximum error
caption = 'Maximum error for RBF interpolant.';
PlotError2D(xe,ye,Pf,exact,maxerr,neval,fview,caption)