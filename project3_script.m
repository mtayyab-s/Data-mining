A= csvread('C.txt');
labels = A(1,:);
data = A(2:size(A,1),:);
k=40;


[clusterID center]=kmeans(data',k);
C= confusionMatrix(labels,clusterID');
acc = (sum(diag(C))/sum(sum(C)))*100


