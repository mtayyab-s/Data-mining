function [clusterID  center] = Kmeans(data,k)
j=0;
R = datasample(data,k,2,'Replace',false); % choosing random instances and populating the k cers
P= zeros(size(data,1),k);
result = zeros(1,size(data,2));
flag = 0;
clust{k,size(data,2)}=[];
while flag ==0 && j<151
for n=1:size(data,2)
temp = data(:,n);
temp2 = repmat(temp,1,size(R,2));
diff = R - temp2;
answer = sqrt(sum(diff.^2,1));
[m i] = min(answer);
clust{i} = [clust{i},n];
result(:,n)=i;
end
for h =1:k
    temp3=clust{h};
    addition = R(:,h);
    for b=1:size(temp3,2)
        addition =addition+data(:,temp3(1,b));
    end
    average= addition./size(clust{h},2);
    P(:,h) = average;
end
if P == R 
flag =1;
end
R=P;
j=j+1;
end
clusterID = result;
center = R;
end

