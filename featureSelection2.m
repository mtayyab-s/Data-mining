function y = featureSelection2(A,limit,label )
%A = csvread('c.txt');
%label = A(1,:);
classes = unique(label);
k = numel(classes);

%A = A(2:size(A,1),:);
answer=0;
den = 0;
answer = zeros(size(A,1),1);
for j=1:size(A,1)
    feature = A(j,:);
    [p,tbl] = anova1(feature,label,'off');
    answer(j) = tbl{2,5};
end

[i v] = sort(answer,'descend');
v=v(1:limit);
y=v;

end

