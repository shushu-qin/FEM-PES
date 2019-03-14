function [X,T] = createRectangleMesh(dom,elementType,elementDegree,nx,ny)
%
% [X,T] = createRectangleMesh(dom,elementType,elementDegree,nx,ny)
% Creates the topology of an structured and uniform mesh
% over a rectangular domain [x1,x2]x[y1,y2]
%
% Input:
%   dom = [x1,x2,y1,y2]:  vertices' coordinates
%   elementType: 0 for quadrilateral and 1 for triangles
%   elementDegree: interpolation degree (1 or 2)
%   nx,ny: number of elements in each direction
% Output:
%   X:  nodal coordinates
%   T:  connectivities



x1 = dom(1); x2 = dom(2);
y1 = dom(3); y2 = dom(4);

npx = nx*elementDegree+1;
npy = ny*elementDegree+1;
npt = npx*npy;
x = linspace(x1,x2,npx);
y = linspace(y1,y2,npy);
[x,y] = meshgrid(x,y);
X = [reshape(x',npt,1), reshape(y',npt,1)];


% Connectivities
if elementType == 0            % Quadrilaterals
    if elementDegree == 1         % Q1
        T = zeros(nx*ny,4);
        for i=1:ny
            for j=1:nx
                ielem = (i-1)*nx+j;
                inode = (i-1)*(npx)+j;
                T(ielem,:) = [inode   inode+1   inode+npx+1   inode+npx];
            end
        end
    elseif elementDegree == 2     % Q2
        T = zeros(nx*ny,9);
        for i=1:ny
            for j=1:nx
                ielem = (i-1)*nx + j;
                inode = (i-1)*2*npx + 2*(j-1) + 1;
                nodes_aux = [inode+(0:2)  inode+npx+(0:2)  inode+2*npx+(0:2)];
                T(ielem,:) = nodes_aux([1  3  9  7  2  6  8  4  5]);
            end
        end
    else
        error('Unavailable quadrilatera');
    end
elseif elementType == 1        % Triangles
    if elementDegree == 1             % P1
        nx_2 = nx/2; ny_2 = ny/2;
        T = zeros(2*nx*ny,3);
        for i=1:ny
            for j=1:nx
                ielem = 2*((i-1)*nx+j)-1;
                inode = (i-1)*(npx)+j;
                nodes = [inode   inode+1   inode+npx+1    inode+npx];
                if (i<=ny_2 && j<=nx_2) || (i>ny_2 && j>nx_2)
                    T(ielem,:) = nodes([1,2,3]);
                    T(ielem+1,:) = nodes([1,3,4]);
                else
                    T(ielem,:) = nodes([1,2,4]);
                    T(ielem+1,:) = nodes([2,3,4]);
                end
            end
        end
    elseif elementDegree == 2         % P2
        nx_2 = round(nx/2); ny_2 = round(ny/2);
        
        T = zeros(2*nx*ny,6);
        for i=1:ny
            for j=1:nx
                ielem=2*((i-1)*nx+j)-1;
                inode=(i-1)*2*(npx)+2*(j-1)+1;
                nodes = [inode+(0:2)  inode+npx+(0:2)  inode+2*npx+(0:2)];
                if (i<=ny_2 && j<=nx_2) || (i>ny_2 && j>nx_2)
                    T(ielem,:)   = nodes([1  9  7  5  8  4]);
                    T(ielem+1,:) = nodes([1  3  9  2  6  5]);
                else
                    T(ielem,:)   = nodes([1  3  7  2  5  4]);
                    T(ielem+1,:) = nodes([3  9  7  6  8  5]);
                end
            end
        end
        
    else
        error('Unavailable triangle')
    end
end



