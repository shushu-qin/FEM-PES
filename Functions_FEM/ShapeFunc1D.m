function shapeFun = ShapeFunc1D(elementdegree) 
%  Shape functions for 1D linear and quadratic
% Input:    
%   elementdegree: type of element (1 for linear and 2 for quadratic)
%
% Output:
%   Linear1D: element structure that stores integration points, weights,
%   shape functions and derivatives

if elementdegree ==1
    quadrature=2;
    [zgp,wgp] = gaussQuadrature1D(quadrature, -1, 1);
    xi = zgp(:,1);
    N= [(1-xi)/2, (1+xi)/2];
    Nxi= [-1/2,-1/2; 1/2,1/2];
%     quadrature=1;
%     [zgp,wgp] = gaussQuadrature1D(quadrature, -1, 1);
%     xi = zgp(:,1);
%     N= [(1-xi)/2, (1+xi)/2];
%     Nxi= [-1/2; 1/2];

    
elseif elementdegree == 2
    quadrature=4;
    [zgp,wgp] = gaussQuadrature1D(quadrature, -1, 1);
    xi = zgp(:,1);
    N= [1/2*xi.*(xi-1), -(xi-1).*(xi+1), 1/2*xi.*(xi+1)];
    Nxi= [xi-1/2, -2*xi, xi+1/2];
end

shapeFun.zgp = zgp; 
shapeFun.wgp = wgp; 
shapeFun.N = N; 
shapeFun.Nxi = Nxi; 

end