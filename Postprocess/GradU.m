function [ux uy] = GradU(X,T,RefElement,Example,u)
k = Example.k;
nen  = RefElement.nen;
elem = RefElement.elem;
nelem = size(T,1);
nNodes = size(X,1);
% Degrees of freedom in each element
nedofT = nen; 
% Gradient of U at each node
gradU = zeros(nNodes,2);
% Shape function
if elem == 1
    if nedofT == 3
        zgp=[1,0;0,1;0,0];
        [N,Nxi,Neta] = ShapeFunc(elem,nedofT,zgp);
    elseif nedofT == 6
        zgp=[1,0;0,1;0,0;0.5,0;0.5,0.5;0,0.5];
        [N,Nxi,Neta] = ShapeFunc(elem,nedofT,zgp);
    else
        error('Unavailable type of element');
    end
elseif elem == 0
    if nedofT == 4
        zgp=[-1,-1;1,-1;1,1;-1,1];
        [N,Nxi,Neta] = ShapeFunc(elem,nedofT,zgp);
    elseif nedofT == 9
        zgp=[-1,-1;1,-1;1,1;-1,1; 0,-1;1,0;0,1;-1,0;0,0];
        [N,Nxi,Neta] = ShapeFunc(elem,nedofT,zgp);
    else
        error('Unavailable type of element');
    end
end
for ielem = 1:nelem % Loop in elements
    Te = T(ielem,:);
    Xe = X(Te,:);
    xe = Xe(:,1); ye = Xe(:,2); nen = length(xe); 
    ue = u(Te);
    gradU_in = zeros(1,2);

    for iNode = 1:nedofT
        Nxi_in  = Nxi(iNode,:);
        Neta_in = Neta(iNode,:);
        %Jacobian matrix
        J = [Nxi_in*xe Nxi_in*ye;Neta_in*xe Neta_in*ye]; %Jacobian in 2D
        % Gradient matrix
        Ngp_xy = J\[Nxi_in;Neta_in];
        %Calculation elemental gradient of U
        gradU_in =ue'*Ngp_xy';
        gradU(Te(iNode),:) = gradU(Te(iNode),:)+gradU_in;
    end  
    
end
for iNode = 1:nNodes
    n = find(T==iNode);
    gradU(iNode,:) = gradU(iNode,:)/length(n);
end
ux = gradU(:,1);
uy = gradU(:,2);