A = csvread('trainDataXY.txt');
B = csvread('testDataXY.txt');
train_labels = A(1,1:size(A,2));
test_labels = B(1,1:size(B,2));
train=(A(2:size(A,1),1:size(A,2))');
test=(B(2:size(B,1),1:size(B,2))');

model = svmtrain(train_labels',train,'-s 0  -t 0 -c 1 -g 0.07 -b 1 -q');
[predict_label, accuracy, prob_estimates] = svmpredict(test_labels',test, model, '-b 1');
predict_label'