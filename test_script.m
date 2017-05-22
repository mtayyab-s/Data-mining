 % number of points considered

data = csvread('c.txt');
label = data(1,:);
data = data(2:size(data,1),:);
 
data = data';
N = 2^11;

 knn    = ceil(15); % each patch will only look at its knn nearest neighbors in R^d
sigma2 = 100; % determines strength of connection in graph... see below

%% now let's get pairwise distance info and create graph 
m                = size(data,1);
dt               = squareform(pdist(data));
[srtdDt,srtdIdx] = sort(dt,'ascend');
dt               = srtdDt(1:knn+1,:);
nidx             = srtdIdx(1:knn+1,:);

% nz   = dt(:) > 0;
% mind = min(dt(nz));
% maxd = max(dt(nz));

% compute weights
tempW  = exp(-dt.^2/sigma2); 

% build weight matrix
i = repmat(1:m,knn+1,1);
W = sparse(i(:),double(nidx(:)),tempW(:),m,m); 
W = max(W,W'); % for undirected graph.

% The original normalized graph Laplacian, non-corrected for density
ld = diag(sum(W,2).^(-1/2));
DO = ld*W*ld;
DO = max(DO,DO');%(DO + DO')/2;

% get eigenvectors
[v,d] = eigs(DO,100,'la');
v=v';
dat = [label;v];
k=5;
[train test] = cValidation(dat,k);      % returns K folds of training and

 
 
 
for c = 1:k
tr =train{c};
ts =test{c};
train_labels = tr(1,1:size(tr,2));
test_labels = ts(1,1:size(ts,2));
tr=(tr(2:size(tr,1),1:size(tr,2))');
ts=(ts(2:size(ts,1),1:size(ts,2))');
%[predKNN accuracyknn] = knn(tr,ts,train_labels,test_labels,1);
%[predCentroid accuracycentroid] = centroid(tr,ts,train_labels,test_labels);
%[predRegression accuracyregr] = linearRegression(tr,ts,train_labels,test_labels);
[predSVM accuracysvm]=svmClassifier(tr,ts,train_labels,test_labels);
%accuracyknn
%accuracycentroid
%accuracyregr
%accuracysvm
%knn_accuracy{c} = accuracyknn;
%Centroid_accuracy{c} = accuracycentroid;
%Regression_accuracy{c} = accuracyregr;
SVM_accuracy{c} = accuracysvm;
end
%AverageAccuracyKNN = sum([knn_accuracy{1:k}])/k
%AverageAccuracyCentroid = sum([Centroid_accuracy{1:k}])/k
%AverageAccuracyRegression = sum([Regression_accuracy{1:k}])/k
AverageAccuracySVM = sum([SVM_accuracy{1:k}])/k