function [Ke,fe] = EleMat(Xe,N,Nxi,Neta,nedofT,ngaus,wgp,Example)

% [Ke,fe] = EleMat(Xe,N,Nxi,Neta,nedof,ngaus,wgp,k,SourceTermFunction)
% Elemental matrix and source term vector for a 2D Poisson problem
% Xe: nodal coordinates
% N, Nxi, Neta: shape functions and their derivatives
% nedof: number of degrees of freedom in the element
% ngaus, wgp: number of integration points and integration weights
% Example: material parameter

k = Example.k;
Ke = zeros(nedofT); 
fe = zeros(nedofT,1); 

xe = Xe(:,1); ye = Xe(:,2); nen = length(xe); 

for ig = 1:ngaus
    N_ig    = N(ig,:);
    Nxi_ig  = Nxi(ig,:);
    Neta_ig = Neta(ig,:);

    %Jacobian matrix
    J = [Nxi_ig*xe Nxi_ig*ye;Neta_ig*xe Neta_ig*ye]; %Jacobian in 2D
    dvolume=wgp(ig)*det(J); %Differential of volume of isoparametric transformation
         
    %Calculation elemental force vector

    Ngp_xy = J\[Nxi_ig;Neta_ig]; %Value of shape functions with respect to x and y in gauss point
    
    Ke = Ke + Ngp_xy'*k*Ngp_xy*dvolume;
    x_ig = N_ig*Xe;
    
    %Calculation elemental force vector

    fe = fe + SourceTerm(x_ig,Example)*N_ig'*dvolume;
end



