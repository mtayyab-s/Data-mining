function [pred acc] = svmClassifier(train,test,train_labels,test_labels )

model = svmtrain(train_labels',train,'-s 0  -t 0  -c 1 -g 0.07 -b 1 -q');
[predict_label, accuracy, prob_estimates] = svmpredict(test_labels',test, model, '-b 1');
pred = predict_label';
acc =accuracy;
acc=acc(1:1);

end

