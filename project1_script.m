A = csvread('trainDataXY.txt');
B = csvread('testDataXY.txt');
train_labels = A(1,1:size(A,2));
test_labels = B(1,1:size(B,2));
train=(A(2:size(A,1),1:size(A,2))');
test=(B(2:size(B,1),1:size(B,2))');

%calling knn function
knn(train,test,train_labels,test_labels,3)

%calling centroid function
centroid(train,test,train_labels,test_labels)

%calling linear regression function
linearRegression(train,test,train_labels,test_labels)

%calling svm function
svmClassifier(train,test,train_labels,test_labels)
[p a ] =svmClassifier(train,test,train_labels,test_labels);

