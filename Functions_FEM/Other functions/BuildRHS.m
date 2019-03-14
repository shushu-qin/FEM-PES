function [fe]=BuildRHS(Xe,Element,nedof,S,nodesNeumann)
k = 1;
wgp = Element.wgp;
zgp = Element.zgp;
N=Element.N;
Nxi=Element.Nxi;
Neta=Element.Neta;

fe=zeros(nedof,1);

nnodes = size(Xe,1); %Number of nodes in the element
xe = Xe(:,1); ye = Xe(:,2); %x and y components of element

ngaus=length(wgp); %Number of integration points for the element

%Loop on integration points
for gausspoint=1:ngaus
    Ngp=N(gausspoint,:); %Value shape function on gauss point
    Ngp_xi=Nxi(gausspoint,:); %Value derivative wrt xi of shape function on gauss point
    Ngp_eta=Neta(gausspoint,:); %Value derivative wrt eta shape function on gauss point
    
    %Jacobian matrix
    J = [Ngp_xi*xe Ngp_xi*ye;Ngp_eta*xe Ngp_eta*ye]; %Jacobian in 2D
    dvolume=wgp(gausspoint)*det(J); %Differential of volume of isoparametric transformation
    
    J_1d = [Ngp_xi*xe Ngp_xi*ye]; %Jacobian in 1D
    darea=wgp(gausspoint)*det(J_1d); %Differential of area of isoparametric transformation
    
    xk = Ngp*Xe; % Coordinates of the points to evaluate the source term function
    
    
    %Definition Neumann Boundary Conditions
    g=3; %Tension force from Neumann boundary conditions
              
    %Calculation elemental force vector
    fe = fe + S(xk)*Ngp'*dvolume + Ngp'*g*nodesNeumann*darea;
end
