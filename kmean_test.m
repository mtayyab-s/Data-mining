A= csvread('c.txt');
data = A(2:size(A,1),:);
k=10;
j=0;
R = datasample(data,k,2,'Replace',false); % choosing random instances and populating the k clusters
P= zeros(size(data,1),k);
cluster =zeros(1,size(data,2));
flag = 0;
while flag ==0 
for n=1:size(data,2)
temp = data(:,n);
temp2 = repmat(temp,1,size(R,2));
diff = R - temp2;
answer = sqrt(sum(diff.^2,1));
[m i] = min(answer);
cluster(n)=i;
P(:,i) = (R(:,i)+temp)/2;
end
if P == R 
flag =1;
end
R=P;
j=j+1;
end