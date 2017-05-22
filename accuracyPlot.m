function accuracyPlot(A,N)   %N is the size of the number rows(dimensions)

x = [5,10,20,30,50];% x-axis
shape= {'ro','r^','r*','r+'};
Col = {'b','r','m','g'};
 for i =1:4   % set the value equal to the algorithms you implemented
base = A(1,i); % selecting the baseline for the algorithm
base = repmat(base,5,1); %repeating the baseline for comparison for all 
data = A(2:N-1,i);
plot(x,base,'color',Col{i});%plotiing the baseline
hold on
h(i)= plot(x,data,'color',Col{i}); %plotting for the algorithm
plot(x,data,shape{i},'color',Col{i});%plotting the markers on the graph
end
 h1 = h(1);
h2 = h(2);
h3 = h(3);
h4 = h(4);
legend([h1 h2 h3 h4],{'knn','centroid','linear regression', 'SVM'});
xlabel ('dimensions');
ylabel('accauracy');
title('Hand-Written-26-letters');

end

