function [result,W] = LDA(X,Y,r)

result=0;
W=0;
[d,n]=size(X);
[nY,dum]=size(Y);
 i=1;
 classLabels=unique(Y');
 NumberOfClasses = size(classLabels,2);
 r=NumberOfClasses-1;
 localMean = cell(1,NumberOfClasses);
 covValue = cell(1,NumberOfClasses);
 sizeC=zeros(1,NumberOfClasses);
    
 % Compute local Mu, cov matrix, and number of observation of
 % for each class 
 for classLab=unique(Y')
    Xc=X(:,Y==classLab);
    localMean(i) = {mean(Xc,2)};
    covValue(i) = {cov(Xc')};
    sizeC(i)=size(Xc,2);
    i=i+1;
 end
 
%Computing  the Global Mean
globalMean = zeros(d,1);
 for i = 1:NumberOfClasses
   globalMean =globalMean+localMean{i};
 end
globalMean=globalMean./NumberOfClasses;
    
 %SB: Betweeness class scatter matrix
 %SW: Scatter Class Matrix
 SB = zeros(d,d);
 SW = zeros(d,d);
 for i = 1:NumberOfClasses
    SB = SB + sizeC(i).*(localMean{i}-globalMean)*(localMean{i}-globalMean)';
    SW = SW+covValue{i};
 end

 [V,D] = eig(SB,SW);
 eigval=diag(D);
    
 % Sort invSw_by_SB (which is a matrix of eigen vectors) and then select 
 % the top vectors assocaited with the top eigen values
    
 % Sorting
 [sort_eigval,sort_eigval_index]=sort(eigval,'descend');
 
 % Selecting the top vectors
 W=V(:,sort_eigval_index(1:r));
   
 % Now result has the reduced dimensions in data sample X.
 result = W'*X;
   
    
end