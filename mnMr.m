function [ index answer] = mnMr(data,k)
 label c= data(1,:);
data = data(2:size(data,1),:);
[a b] = unique(label);
for j=1:size(data,1)
for i= 1:size(b,1)-1
add= sum(data(j,b(i):b(i+1)-1));
varianc(i) = var(data(j,b(i):b(i+1)-1));
avg(i)=add/(b(i+1)-b(i));
n_k(i) = (b(i+1)-b(i));A
end
var_temp = var(data(j,b(size(b,1)):size(data(j,:),2)));
varianc = [varianc var_temp];
temp = sum(data(j,b(size(b,1)):size(data(j,:),2)));
temp = temp/ (size(data(j,:),2) -b(size(b,1))+1);
temp2 = (size(data(j,:),2) -b(size(b,1))+1);
avg = [avg temp];
n_k = [n_k temp2];
g_bar = sum(data(j,:))/(size(data,2));
K = size(unique(label),2);
sol = n_k.*((avg - g_bar).^2);
sol = sum(sol);
sol = sol/(K-1);
sigma = (n_k-1).*varianc;
sigma = sum(sigma)./(size(data,2)-K);
sol = sol/sigma;
answer(j) = sol;
end
[i v] = sort(answer,'descend');
v=v(1:k);
index = v;
end

