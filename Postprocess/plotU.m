function plotU(elementType,elementDegree,X,T,u)
% Plot of u
if elementType ==0 && elementDegree == 2
    
ix = [1 5 2 6 3 7 4 8];
patch('vertices', X, 'faces', T(:,ix), 'facevertexcdata',u(:,1)); 
title('u','FontSize',12)
shading interp
elseif elementType ==1 && elementDegree == 2
    
ix = [1 4 2 5 3 6];
patch('vertices', X, 'faces', T(:,ix), 'facevertexcdata',u(:,1)); 
title('u','FontSize',12)
shading interp
else
    
trisurf(T,X(:,1),X(:,2),u(:,1));
title('u','FontSize',12)
end