function [train test ] = cValidation(data,k)
A=data(:,randperm(size(data,2))); %randomizing the dataset

p=floor(size(A,2)/k);   %calculating the size of the fold
i=1;
r = rem(size(A,2),k);   %calculating the remainder
for n=1:k
if(r>0)
y{n}=A(:,i:i+p-1+1);  %calculating test data
else
y{n}=A(:,i:i+p-1);
end
r = r-1;
i=i+p;
end

for l=1:k
ts{l} = y{l};
if l==1
tr{l} = [y{l+1:k}];   %computing the training data
else
temp1 = [y{l+1:k}];
temp2 = [y{1:l-1}];
tr{l} =[temp1,temp2];
end
end
train=tr;
test = ts;

end

