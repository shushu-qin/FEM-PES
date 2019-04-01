function plotVector(scalefactor,X,T,RefElement,Example,elementType,u)
[Xcenter ux uy] = GradU(X,T,RefElement,Example,u);
PlotMesh(T,X,elementType,'k-');
hold on;
quiver(Xcenter(:,1),Xcenter(:,2),ux*scalefactor,uy*scalefactor,'b-','Linewidth',1,'AutoScale','off')% % Plot of u_ex
