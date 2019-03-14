function Element = ReferenceElement(elementType,elementDegree)
% 
% Element = SetRefElement()
% Reference element properties (type of element, degree, number of nodes,
% nodal coordinates, integration points and weights, shape functions
% evaluated at the integration points)



if elementType == 1 
    if elementDegree == 1
        nen = 3;
        Element.name   ='TRIP1'; %%%%%%
        ngaus = 3;
    elseif elementDegree == 2
        nen = 6;
        Element.name   = 'TRIP2'; %%%%%%
        ngaus = 7;
    else
        error ('Error in ShapeFunc: unavailable triangle');
    end
elseif elementType == 0
    if elementDegree == 1
        nen = 4;
        Element.name   = 'QUAP1'; %%%%%%
        ngaus = 16;
    elseif elementDegree == 2
        nen = 9;
        Element.name   = 'QUAP2'; %%%%%%
        ngaus = 16;
    else
        error ('Error in ShapeFunc: unavailable quadrilateral');
    end
end

        
Element.elem   = elementType; 

Element.nen    = nen; 
Element.degree = elementDegree; 
Element.Xe_ref = [1,0; 0,1; 0,0]; 

Element.ngaus = ngaus; 
[zgp,wgp] = Quadrature(elementType, ngaus); %Call function to obtain integration points and weights
[N,Nxi,Neta] = ShapeFunc(elementType,nen,zgp); %Call function to obtain shape functions
Element.zgp = zgp; 
Element.wgp = wgp; 
Element.N    = N; 
Element.Nxi  = Nxi; 
Element.Neta = Neta; 
