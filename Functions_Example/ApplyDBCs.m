function C = ApplyDBCs(X,Example,tol_h)
%
% C = ApplyDBCs(X,Example,tol_h)
% C: two-column matrix with the imposed degreess of freedom in the first
% column and the corresponding values in the second one. 

zeroNodes = Example.zeroNodes;
C = zeros(length(zeroNodes),2);
for i = 1:size(zeroNodes,1)
    C(i,1) = zeroNodes(i,1);
    C(i,2) = zeroNodes(i,2); % assign 0
end

