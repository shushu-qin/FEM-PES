function [errL2, errH1] = ComputeErrorsFEM(X,T,u,RefElement,Example)

nen  = RefElement.nen; 
elem = RefElement.elem; 

errL2 = 0; normL2 = 0; 
errH1 = 0; normH1 = 0; 
%--------------------------------------------------------------------------
% STANDARD ELEMENTS 
ngaus = RefElement.ngaus; 
wgp = RefElement.wgp; 
N = RefElement.N; 
Nxi = RefElement.Nxi; 
Neta = RefElement.Neta; 

for ielem = 1:size(T,1)
    Te = T(ielem,:);
    Xe = X(Te,:);
    ue = u(Te,:); 
    %Xe = X(Te);
    %ue = u(Te); 
    
    [errL2_e,errH1_e,normL2_e,normH1_e] = ComputeElementalErrors(Xe,ue,N,Nxi,Neta,ngaus,wgp,Example); 
    
    errL2 = errL2 + errL2_e;   normL2 = normL2 + normL2_e;
    errH1 = errH1 + errH1_e;   normH1 = normH1 + normH1_e;
end

normL2 = sqrt(normL2); errL2 = sqrt(errL2)/normL2; 
normH1 = sqrt(normH1); errH1 = sqrt(errH1)/normH1; 


%--------------------------------------------------------------------------
function [errL2_e,errH1_e,normL2_e,normH1_e] = ComputeElementalErrors(Xe,u_e,N,Nxi,Neta,ngaus,wgp,Example)

xe = Xe(:,1); ye = Xe(:,2); nen = length(xe); 

errL2_e = 0; normL2_e = 0; 
errH1_e = 0; normH1_e = 0; 
for ig = 1:ngaus
    N_ig    = N(ig,:);
    Nxi_ig  = Nxi(ig,:);
    Neta_ig = Neta(ig,:);

    J = [Nxi_ig*xe, Nxi_ig*ye; Neta_ig*xe  Neta_ig*ye];
    dvolume = wgp(ig)*det(J); 
        
    res = J\[Nxi_ig; Neta_ig];
    nx = res(1,:); 
    ny = res(2,:); 
       
    uh = N_ig*u_e(:,1); uh_x = nx*u_e(:,1); uh_y = ny*u_e(:,1); 

    pt_xy = N_ig(:,1:nen)*[xe, ye]; 
    [u,u_x,u_y] = ExactSol(pt_xy,Example);
    
    normL2_e = normL2_e + (u^2 )*dvolume; 
    normH1_e = normH1_e + (u_x^2)*dvolume; 
    errL2_e = errL2_e + ((u - uh)^2 )*dvolume; 
    errH1_e = errH1_e + ((u_x-uh_x)^2)*dvolume; 
end