function y=lapl_eig(X,e,sigma2,m)
[l,N]=size(X);
% Computation of the (squared Euclidean) distances between vectors
dist=zeros(N,N);
for i=1:N
    dist(i,:)=((sum( (X(:,i)*ones(1,N)-X).^2)));
end
sigma_2 =max(dist(:));
sigma_2 = sigma_2.^2;
%knn = sort(dist,2);
% Computation of the weight matrix W
%W=exp(-(dist.^2)/(2*sigma2)).*(dist<e^2);
W=exp(-(dist.^2)/(2*sigma_2));
D=diag(sum(W));

%Computation of the matrices L, L tilda (L1)
L=D-W;

%Eigendecomposition of L (solving L*V=D*V*E).
[V,E]=eig(L,D);
de=diag(E);
[Y,I]=sort(de);

%Number of zero or almost zero eigenvalues
t=sum(Y<10^(-9));

%The m eigenvectors that correspond to m smallest nonzero
%eigenvalues
y=V(:,I(t+1:t+m))';

