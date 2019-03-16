function C = ApplyDBCs(X,Example,tol_h)
%
% C = ApplyDBCs(X,Example,tol_h)
% C: two-column matrix with the imposed degreess of freedom in the first
% column and the corresponding values in the second one. 

dom = Example.dom;
DBC = Example.DBC;

x1 = dom(1); x2 = dom(2); 
y1 = dom(3); y2 = dom(4); 

nodes_x1 = find(abs(X(:,1) - x1) < tol_h)*DBC(4); 
nodes_x2 = find(abs(X(:,1) - x2) < tol_h)*DBC(2); 
nodes_y1 = find(abs(X(:,2) - y1) < tol_h)*DBC(1); 
nodes_y2 = find(abs(X(:,2) - y2) < tol_h)*DBC(3); 

nodesDir = unique([nodes_x1; nodes_x2;nodes_y1; nodes_y2]); 
% nodesDir = unique([nodes_x1; nodes_x2;nodes_y2]); 

if nodesDir(1) == 0
    nodesDir = nodesDir(2:end);
end

u = ExactSol(X(nodesDir,:), Example); 
% nDir = length(nodesDir); 

C = [nodesDir,u];

