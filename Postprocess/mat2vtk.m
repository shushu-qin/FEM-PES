function mat2vtk(p,v,T,X)
% open a vtk file
example = 'HW2c';
vtkFile = sprintf('%s.vtk',example);
fileID = fopen (vtkFile, 'w');
typeMesh = 'VTK_TRIANGLE';
typeID = 0;
switch length(T(1,:))
    case 3
        typeID = 5;
    case 4
        typeID = 9;
    case 8
        typeID = 32;
    case 9
        typeID = 23;  
    case 6
        typeID = 22;
end
% print macro
fprintf(fileID,'# vtk DataFile Version 1.0\n');
fprintf(fileID,'%s\n',example);
fprintf(fileID,'ASCII\n\n');
fprintf(fileID,'DATASET UNSTRUCTURED_GRID\n\n');

% print nodes
numNodes = size(X,1);
fprintf(fileID,'POINTS      %5d     float\n',numNodes);
for i = 1:numNodes
    fprintf(fileID,'%16.8e      %16.8e     %16.8e  \n',X(i,:),0);
end
fprintf(fileID,'\n');

% print connctivity
numCells = size(T,1);
numVertices = size(T,2);
fprintf(fileID,'CELLS      %5d     %5d\n',numCells,numCells*(numVertices+1));
if numVertices == 4
    for i = 1:numCells
        fprintf(fileID,'%5d   %5d   %5d   %5d   %5d \n',numVertices,T(i,:)-ones(1,numVertices));
    end
elseif numVertices == 3
    for i = 1:numCells
        fprintf(fileID,'%5d   %5d   %5d   %5d   \n',numVertices,T(i,:)-ones(1,numVertices));
    end
end
fprintf(fileID,'\n');

% print type of meshes
fprintf(fileID,'CELL_TYPES      %5d\n',numCells);
for i = 1:numCells
    fprintf(fileID,'%2d  ',typeID);
end
fprintf(fileID,'\n\n');
fprintf(fileID,'POINT_DATA      %5d\n',numNodes);

% print pressure
fprintf(fileID,'SCALARS pres float\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
for i = 1:numNodes
    fprintf(fileID,'%16.8e   \n',p(i));
end
fprintf(fileID,'\n');

% print velocity vector
fprintf(fileID,'VECTORS velo float\n');
for i = 1:numNodes
    fprintf(fileID,'%16.8e     %16.8e     %16.8e  \n',v(i,:),0);
end
fprintf(fileID,'\n');
fclose(fileID);


