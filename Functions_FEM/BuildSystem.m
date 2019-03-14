function [K,f] = BuildSystem(X,T,RefElement,Example) 
%
% [K,f] = BuildSystem(X,T,RefElement,Example) 
% System of equations obtained by discretizing a 2D Poisson problem
% X, T: mesh coordinates and connectivity matrix
% RefElement: properties of the reference element
% Example: properties of the problem being solved

k=Example.k;
nen  = RefElement.nen; 
nelem = size(T,1); 

% Degrees of freedom in each element
nedofT = nen; 

% Total number of nodes and degrees of freedom
ndofT = size(X,1);

K = zeros(ndofT,ndofT);
f = zeros(ndofT,1);

% Integration weights and shape functions
ngaus = RefElement.ngaus; 
wgp = RefElement.wgp; 
N = RefElement.N; 
Nxi = RefElement.Nxi; 
Neta = RefElement.Neta; 


for ielem = 1:nelem % Loop in elements
    Te = T(ielem,:);
    Xe = X(Te,:);
    
    % Elemental matrix
    [Ke,fe] = EleMat(Xe,N,Nxi,Neta,nedofT,ngaus,wgp,Example);

    % Assembly
    K(Te,Te) = K(Te,Te) + Ke;
    f(Te) = f(Te) + fe;
end

