
function [pred accuracy] = centroidnear(train,test,labels,test_labels)


class_labels = labels;


test_size=size(test,1);
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
labels = datas(1:size(datas,1),size(datas,2));
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
    acc = sum(lab' == test_labels) / numel(test_labels);
pred=lab';
accuracy=100*acc;
end