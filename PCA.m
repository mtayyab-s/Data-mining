function result =PCA(data,k)

data = data(2:size(data,1),:);
avg = sum(data,2)/size(data,2);
avg = repmat(avg,1,size(data,2));
data = data-avg;
C = (data*data')/size(data,2);
[V D] = eig(C);
[D order] = sort(diag(D),'descend'); 
V = V(:,order);
newX= data'*V(:,1:k);
result = newX';

end

