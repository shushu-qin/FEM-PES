function [Ke,fe] = EleMatElasticity(Xe,N,Nxi,Neta,nedof,ngaus,wgp,mu,nu)
% 
% [Ke,fe] = EleMatElasticity(Xe,N,Nxi,Neta,nedof,ngaus,wgp,mu,nu)
% Elemental matrix and source term vector for a 2D elasticity problem
% (plane strain)
% Xe: nodal coordinates
% N, Nxi, Neta: shape functions and their derivatives
% nedof: umber pf degrees of freedom in the element
% ngaus, wgp: number of integration points and integration weights
% mu,nu: material properties 

if length(mu) == 1
    mu = mu*ones(ngaus,1); 
    nu = nu*ones(ngaus,1); 
end

Ke = zeros(nedof); 
fe = zeros(nedof,1); 

B = zeros(3, nedof); 
xe = Xe(:,1); ye = Xe(:,2); nen = length(xe); 

for ig = 1:ngaus
    mu_ig = mu(ig); nu_ig = nu(ig); 
    % plane strain
    C =[1-nu_ig,nu_ig,0; nu_ig,1-nu_ig,0; 0,0,(1-2*nu_ig)/2];
    C = C*2*mu_ig/(1-2*nu_ig);
   
    N_ig    = N(ig,:);
    Nxi_ig  = Nxi(ig,:);
    Neta_ig = Neta(ig,:);

    Jacob = [Nxi_ig(1:nen); Neta_ig(1:nen)]*Xe;
    J = det(Jacob); 
    dvolu = wgp(ig)*J; 
    
    res = Jacob\[Nxi_ig; Neta_ig];
    dNdx_ig = res(1,:); 
    dNdy_ig = res(2,:); 
    
    B(1,1:2:end) = dNdx_ig;
    B(2,2:2:end) = dNdy_ig;
    B(3,1:2:end) = dNdy_ig; B(3,2:2:end) = dNdx_ig;
    Ke = Ke + B'*C*B*dvolu; 
    
    pt_xy = N_ig(:,1:nen)*[xe, ye]; 
    f_ig = SourceTerm(pt_xy, mu); 
    N_T_ig = [reshape([1;0]*N_ig,1,nedof); reshape([0;1]*N_ig,1,nedof)]; 
    fe = fe + N_T_ig'*f_ig*dvolu;
end
