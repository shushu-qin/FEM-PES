function [Ke]=BuildLHS(Xe,Element,mu,nedof)

%mu represents k(x) that we don't know if it is a scalar, function or
%matrix
wgp = Element.wgp;
zgp = Element.zgp;
N=Element.N;
Nxi=Element.Nxi;
Neta=Element.Neta;


Ke=zeros(nedof);

xe = Xe(:,1); ye = Xe(:,2); %x and y nodal components of element

ngaus=length(wgp); %Number of integration points for the element

%Loop on integration points
for gausspoint=1:ngaus
    Ngp=N(gausspoint,:); %Value shape function on gauss point
    Ngp_xi=Nxi(gausspoint,:); %Value derivative wrt xi of shape function on gauss point
    Ngp_eta=Neta(gausspoint,:); %Value derivative wrt eta shape function on gauss point
 
    
    %Jacobian matrix
    J = [Ngp_xi*xe Ngp_xi*ye;Ngp_eta*xe Ngp_eta*ye];
    dvolume=wgp(gausspoint)*det(J); %Differential of volume of isoparametric transformation
    
    Ngp_xy = J\[Ngp_xi;Ngp_eta]; %Value of shape functions with respect to x and y in gauss point
    Ngp_x = Ngp_xy(1,:);  %Value derivative shape function wrt x in gauss point
    Ngp_y = Ngp_xy(2,:);  %Value derivative shape function wrt y in gauss point
    
    %Creates matrix B in 2D for the derivatives basis functions computed at
    %gauss pointc
      
    Ke = Ke + Ngp_xy'*k*Ngp_xy*dvolume;
end
  