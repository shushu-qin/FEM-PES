function [K,f]=BuildSystem(X,T,Element,S,mu,nodesNeumann)

nnodestotal = size(X,1);
nedof = 2*nnodestotal;
nelements = size(T,1);

K=zeros(nnodestotal,nnodestotal); %Space allocation for assemblying
f=zeros(nnodestotal,1);

%Loop in elements
for ielement=1:nelements
    Te=T(ielement,:); %nodes in the element
    Xe=X(Te,:); %coordinates nodes in the element
    [Ke]=BuildLHS(Xe,Element,mu,nedof);
    [fe]=BuildRHS(Xe,Element,nedof,S,nodesNeumann);
    K(Te,Te)=K(Te,Te)+Ke; %assembly of elemental matrix
    f(Te) = f(Te) + fe;
end

