data = csvread('Hand-Written-26-letters.txt');
label = data(1,:);
data = data(2:size(data,1),:);
[a b] = LDA(data,label',2);

 
a = [label; a];
k =5;
[train test] = cValidation(a,k);      % returns K folds of training 

%applying k-fold cross validation
for c = 1:k
tr =train{c};
ts =test{c};
train_labels = tr(1,1:size(tr,2));
test_labels = ts(1,1:size(ts,2));
tr=(tr(2:size(tr,1),1:size(tr,2))');
ts=(ts(2:size(ts,1),1:size(ts,2))');

%calling knn function
[predKNN accuracyknn] = knn(tr,ts,train_labels,test_labels,1);

%calling centroid function
[predCentroid accuracycentroid] = centroid(tr,ts,train_labels,test_labels);

%calling linear regression function
[predRegression accuracyregr] = linearRegression(tr,ts,train_labels,test_labels);

%calling SVM function
[predSVM accuracysvm]=svmClassifier(tr,ts,train_labels,test_labels);
knn_accuracy{c} = accuracyknn;
Centroid_accuracy{c} = accuracycentroid;
Regression_accuracy{c} = accuracyregr;
SVM_accuracy{c} = accuracysvm;
end
AverageAccuracyKNN = sum([knn_accuracy{1:k}])/k
AverageAccuracyCentroid = sum([Centroid_accuracy{1:k}])/k
AverageAccuracyRegression = sum([Regression_accuracy{1:k}])/k
AverageAccuracySVM = sum([SVM_accuracy{1:k}])/k
