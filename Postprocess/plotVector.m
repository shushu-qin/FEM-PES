function plotVector(scalefactor,Xcenter,ux,uy)

quiver(Xcenter(:,1),Xcenter(:,2),ux*scalefactor,uy*scalefactor,'b-','Linewidth',1,'AutoScale','off')% % Plot of u_ex
