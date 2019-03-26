function WritingFile(X,T,u,sol)

fileID = fopen('Solution.vtk','w');
fprintf(fileID,'# vtk DataFile Version 1.0\nSolution\nASCII\n');
fprintf(fileID,'\nDATASET UNSTRUCTURED_GRID\n\n');

X = [X zeros(length(X),1)];
coord = [X(:,1)'; X(:,2)'; X(:,3)'];

fprintf(fileID,'POINTS      %3d float\n',length(X));
fprintf(fileID,'%15.8e     %15.8e     %15.8e\r\n',coord);


switch length(T(1,:))
    case 3
        kk = 5;
    case 4
        kk = 9;
    case 8
        kk = 32;
    case 9
        kk = 23;  
    case 6
        kk = 22;
end

newT = length(T(1,:))*ones(length(T),1)';
for i=1:length(T(1,:))
    newT = [newT;T(:,i)'-1];
end

fprintf(fileID,'\nCELLS\t\t%3d     %3d\n',length(T),length(T)*length(newT(:,1)));
for i=1:length(T(:,1))
    for j=1:length(newT(:,1))
        fprintf(fileID,'%3d     ',newT(j,i));
    end
    fprintf(fileID,'\n');
end

variable = zeros(1,length(T))'+kk;
fprintf(fileID,'\nCELL_TYPES %10d\n',length(T));
fprintf(fileID,'%3d\n',variable);
fprintf(fileID,'\n');

fprintf(fileID,'\nPOINT_DATA %10d\n',length(u));
fprintf(fileID,'SCALARS U float\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
fprintf(fileID,'%15.8e\n',u);
fprintf(fileID,'SCALARS SOL float\n');
fprintf(fileID,'LOOKUP_TABLE default\n');
fprintf(fileID,'%15.8e\n',sol);

fclose(fileID);