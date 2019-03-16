function [zgp,wgp] = Quadrature(elem, ngaus) 
% 
% [zgp,wgp] = Quadrature(elem, ngaus)
%
% Input:    
%   elem:   type of element (0 for quadrilaterals and 1 for triangles)
%   ngaus:  number of Gauss points in each element
% Output:   
%   zgp, wgp: Gauss points and weights on the reference element


if elem == 0
    if ngaus == 4    % degree 1
        pos1 = 1/sqrt(3); 
        zgp=[-pos1   -pos1 
                pos1   -pos1 
                pos1    pos1 
               -pos1    pos1]; 
        wgp=[ 1 1 1 1];
    elseif ngaus == 9  % degree 2 
        pos1 = sqrt(3/5);
        zgp=[-pos1   -pos1
                   0   -pos1
                pos1   -pos1
               -pos1     0
                  0      0
                pos1     0
               -pos1    pos1
                  0     pos1
                pos1    pos1];
        pg1=5/9; pg2=8/9; pg3=pg1;
        wgp= [pg1*pg1 pg2*pg1 pg3*pg1 pg1*pg2 pg2*pg2 pg3*pg2 pg1*pg3 pg2*pg3 pg3*pg3];
    elseif ngaus == 16
                pos1 = sqrt(525+70*sqrt(30))/35;
        pos2 = sqrt(525-70*sqrt(30))/35;
        paux = [-pos2;-pos1;pos1;pos2];
        unos = ones(size(paux));
        zgp = [ -pos2*unos    paux
                  -pos1*unos    paux
                   pos1*unos    paux
                   pos2*unos    paux ];
        %
        pes1 = sqrt(30)*(3*sqrt(30)-5)/180;
        pes2 = sqrt(30)*(3*sqrt(30)+5)/180;
        waux = [pes2,pes1,pes1,pes2];
        wgp = [pes2*waux, pes1*waux, pes1*waux, pes2*waux];
    else 
        error(' Unavailable quadrature ') 
    end
elseif elem == 1
    if ngaus == 1  % degree 1
        pos1 = 1/3;
        zgp=[pos1   pos1]; 
        wgp = 1/2; 
    elseif ngaus == 3  % degree 2
        pos1 = 1/2;
        zgp = [pos1   pos1
                 0      pos1
                 pos1   0];
        pes1 = 1/6;
        wgp = [pes1   pes1   pes1];
    elseif ngaus == 4  % degree 3
        zgp=[1/3   1/3
               0.6   0.2
               0.2   0.6
               0.2   0.2];
       wgp = [-27/96   25/96   25/96   25/96];
    else
        error(' Unavailable quadrature ') 
    end
else
    error(' Unavailable quadrature ') 
end
