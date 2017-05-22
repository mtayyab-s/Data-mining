function [E,V] = lapheat(DATA,lodim,nn,step,stepsbtwnreport)

% LAPHEAT Laplacian Eigenmaps Algorithm with Heat Kernel weights.
%
% [E,V] = lapbin(DATA,lodim,[nn,step,stepsbtwnreport])
%
% DATA is a N x hidim matrix representing N points in R^hidim
% lodim is a positive integer; you want to map the points in DATA
%   to R^lodim.
% nn is the number of nearest neighbors used to create the graph
%   (10 by default)
% step is a value that can be modified to optimize this code's
%   running on your machine.  L2_distance is called on a step x N matrix.
%
% E is a N x lodim matrix represnting the same N points in R^lodim.
% V is a vector with the lodim smallest positive eigenvectors.
% 
%  E(:,i) and V(i) are the i-th smallest positive eigenvectors/values.
%
% Original code by Misha Belkin (misha@cs.uchicago.edu)
% Modified by Dinoj Surendran (dinoj@cs.uchicago.edu), April/May 2004
%
%  Implements algorithm in Belkin & Niyogi Dec 2001 pages 4-5.


if nargin < 3, nn = 10;end
if nargin < 4, step=500;end
if nargin < 5, stepsbtwnreport=5;end

n=size(DATA,1);
hidim = size(DATA,2);
W=sparse(n,n);
 
sprintf ('Finding a mapping of %d points in R^%d to R^%d\n using the Laplacian Algorithm with HEAT KERNEL weights and %d nearest neighbors\n\n', n, hidim, lodim, nn)

% calculate the adjacency matrix for DATA

count=0;
for i1=1:step:n
    count=count+1;
    i2 = min(i1+step-1,n);
    XX= DATA(i1:i2,:);  
    dt = L2_distance(XX',DATA');
    [Z,I] = sort ( dt,2);
    for i=i1:i2
      vals = Z(i-i1+1,2:nn+1);
      W(i,I(i-i1+1,2:nn+1)) = vals;
      W(I(i-i1+1,2:nn+1),i) = vals';
    end
    if (mod(count,stepsbtwnreport) == 0) 
      disp(sprintf('%d points processed.', i1+step-1));
    end;
end;

[A_i,A_j,A_v] = find (W);
t = mean(A_v)*4;

W = sparse(A_i,A_j,exp(1).^((-1/t)*(A_v.^2)));
n=size(W,1);

D = spdiags(sum(W(:,:),2),0,speye(n));
L = D-W;

opts.tol = 1e-9;
opts.maxit = 200;
opts.issym=1; 
opts.disp = 2; 

[EE,VV] = eigs(L,D,1+lodim,'SM',opts);   

%[EE,VV] = eigs(L,D,1+lodim,1e-2,opts);   

% the smallest eigenvector is in the (1+lodim)-th column (it's not positive)
% we want the first column to correspond to the second smallest evalue
% we want the second column to correspond to the third smallest evalue, etc

V = zeros (1,lodim);
for i = 1 : lodim
  E(:,i) = EE(:,1+lodim-i);
  V(i) = VV(1+lodim-i,1+lodim-i);
end

