function [pred accuracy] = knn(train,test,class_labels,test_labels,k)
predicted_labels = zeros(1,size(test,1));

for sample=1:size(test,1)
M=repmat(test(sample,:),size(train,1),1) ;
dis=sqrt(sum((train-M).^2,2));
[dist,position]=sort(dis);
dist=dist';
position=position';
knearestneighbors=position(1:k);
knearestdistances=dist(1:k);
 
 for i=1:k
        H(i) = class_labels(:,knearestneighbors(i));
    end
	
W = mode(H);
predicted_labels(sample) = W;
end
acc = sum(predicted_labels == test_labels) / numel(test_labels);
pred= predicted_labels;
accuracy=100*acc;
end

