A=csvread('trainDataXY.txt');
B=csvread('testDataXY.txt');
size_instances_A=size(A,2);
size_att_A=size(A,1);
size_instances_B=size(B,2);
size_att_B=size(B,1);
class_labels = A(1,1:size_instances_A);

train=(A(2:size_att_A,1:size_instances_A))';
test =(B(2:size_att_B,1:size_instances_B))';

train_size=size(train,1);
test_size=size(test,1);
valueOfA = zeros(1,test_size);

for sample=1:test_size
M=repmat(test(sample,:),train_size,1) ;
dis=sqrt(sum((train-M).^2,2));
[dist,position]=sort(dis);
dist=dist';
position=position';
knearestneighbors=position(1:3);
 knearestdistances=dist(1:3);
 
 for i=1:3
        H(i) = class_labels(:,knearestneighbors(i));
    end
	
W = mode(H);
valueOfA(sample) = W;
end