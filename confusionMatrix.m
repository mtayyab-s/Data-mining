function [cMatrix] = confusionMatrix(labels,clusterID)
k=size(unique(labels),2);
C = zeros(k,k);
for i=1:size(labels,2)
   C(labels(1,i),clusterID(1,i))=C(labels(1,i),clusterID(1,i))+1;
end
D = -1.*C;
[e f] =  munkres(D);
confusionM = zeros(k,k);
for j=1:size(e,2)
temp = C(:,e(1,j));
confusionM(:,j) = temp;
end
%for d=1:26
%[findMax ind]=max(C(d,:));
%[tek ind2] = max(C(:,ind));
%if(tek==findMax)
%temp = C(:,d);
%C(:,d) = C(:,ind);
%C(:,ind) = temp;
%end
%end
cMatrix = confusionM;

end