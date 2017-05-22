function y = featureSelection(A,limit,label )
%A = csvread('c.txt');
%label = A(1,:);
classes = unique(label);
k = numel(classes);

%A = A(2:size(A,1),:);
answer=0;
den = 0;
for j=1:k
Xj=A(:,label == classes(j));
n(j)=size(Xj,2);
g_k = mean(Xj,2);
g_bar = mean(A,2);
temp = (g_k -g_bar).^2;
temp= n(j).*temp;
answer = answer +temp;
sd  = var(Xj,0,2);
sd_final = (n(j)-1).*sd;
den = den+sd_final;
end

answer = answer./(k-1);
den = den./(size(A,2)-k);
result = answer./den;
[i v] = sort(result,'descend');
v=v(1:limit);
y=v;

end

