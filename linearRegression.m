
function [y accuracy] = linearRegression(train,test,labels,test_labels)
train = train';
test = test';
matrix =zeros(size(unique(labels),2),size(labels,2));
for n = 1:size(labels,2)
for t = 1:size(matrix,1)
temp = labels(1,n);
matrix(temp,n) =1;
end
end
B = pinv(train') *  double(matrix)'  ; 
train_predict = B' * train;
test_predict = B' * test;
[Ytest2value  Ytest2]= max(test_predict,[],1);
[Ytrain2value  Ytrain2]= max(train_predict,[],1);

 
acc = sum(Ytest2 == test_labels) / numel(test_labels);
y= Ytest2;
accuracy=100*acc;
end

