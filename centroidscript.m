A=csvread('trainDataXY.txt');
B=csvread('testDataX.txt');
size_instances_A=size(A,2);
size_att_A=size(A,1);
size_instances_B=size(B,2);
size_att_B=size(B,1);
class_labels = A(1,1:size_instances_A);

train=(A(2:size_att_A,1:size_instances_A))';
test =(B(1:size_att_B,1:size_instances_B))';

train_size=size(train,1);
test_size=size(test,1);
class=unique(class_labels);
total_labels =size(class);
train=[train class_labels'];
datas = zeros(test_size,size(train,2));

[u,ia,ib]=unique(train(:,size(train,2)));
for i=1:length(u)
  C(i)={train(ib==i,:)};
end

no_class =size(unique(class_labels),2);
for i=1:no_class
data{i}=mean(C{i});
end
 for  n =1:size(unique(class_labels),2);
datas(n,:) = data{n};
end
labels = datas(1:size(datas,1),size(datas,2))
datas = datas(1:size(datas,1),1:size(datas,2)-1);
for sample=1:test_size
M=repmat(test(sample,:),size(datas,1),1) ;
dis=sqrt(sum((datas-M).^2,2));
[dist,position]=sort(dis);
dist=dist';
position=position';
knearestneighbors=position(1:1);
knearestdistances=dist(1:1);
 
        lab(sample,:) = labels(knearestneighbors,:);
  
	end