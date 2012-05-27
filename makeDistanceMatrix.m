function DM = makeDistanceMatrix( dsites, ctrs )
%MAKEDISTANCEMATRIX Makes a matrix where the (i,j)th element is the
%Euclidean distance between the ith datasite and the jth center.

[M,s1] = size(dsites); [N,s2] = size(ctrs);
if s1 ~= s2
    error('makeDistanceMatrix','Each input must have the same number of columns (i.e. dimensions).')
end
s = s1;
DM = zeros(M,N);
for d = 1:s
    [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
    DM = DM + (dr-cc).^2;
end

DM = sqrt(DM);

end

