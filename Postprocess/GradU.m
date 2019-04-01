function [Xcenter ux uy] = GradU(X,T,RefElement,Example,u)

nen  = RefElement.nen; 
nelem = size(T,1); 
% Degrees of freedom in each element
nedofT = nen; 

% Total number of nodes and degrees of freedom
ndofT = size(X,1);
% Central points in each elem
Xcenter = size(nelem,nelem);

k = Example.k;
gradU = zeros(length(T),2);
% Integration weights and shape functions
ngaus = RefElement.ngaus; 
wgp = RefElement.wgp; 
N = RefElement.N; 
Nxi = RefElement.Nxi; 
Neta = RefElement.Neta; 

for ielem = 1:nelem % Loop in elements
    Te = T(ielem,:);
    Xe = X(Te,:);
    xe = Xe(:,1); ye = Xe(:,2); nen = length(xe); 
    ue = u(Te);
    gradUe = zeros(1,2);
    for ig = 1:ngaus
        N_ig    = N(ig,:);
        Nxi_ig  = Nxi(ig,:);
        Neta_ig = Neta(ig,:);
        %Jacobian matrix
        J = [Nxi_ig*xe Nxi_ig*ye;Neta_ig*xe Neta_ig*ye]; %Jacobian in 2D
        dvolume=wgp(ig)*det(J);
        % Gradient matrix
        Ngp_xy = J\[Nxi_ig;Neta_ig];
        %Calculation elemental gradient of U
        gradUe =gradUe+ ue'*Ngp_xy';
    end
    Xcenter(ielem,1)=sum(xe)/nen;
    Xcenter(ielem,2)=sum(ye)/nen;
    gradU(ielem,:) = gradUe;
end
ux = gradU(:,1);
uy = gradU(:,2);