% This program solves a 2D Poisson Problem for linear and quadratic
% triangles and quadrilaterals
clear all; close all; %clc
setpath;
comp = 1; % compute error:1
exID = 2;
BC = 1; % 1: all Dirichlet; 2: top-bottom Neumann
Example = SetExample(exID,BC);

elementType = 1; % elementType: 0 for quadrilateral and 1 for triangles
elementDegree = 2;
dom = Example.dom;
nx = 2;
ny = 2;
nmesh = 4;
sizeOfElem = zeros(nmesh,1);
L2u = zeros(nmesh,1);
H1u = zeros(nmesh,1);
if comp
for i = 1:nmesh
    nx = nx*2;
    ny = ny*2;
    [X,T] = createRectangleMesh(dom,elementType,elementDegree,nx,ny);

    RefElement = ReferenceElement(elementType,elementDegree);
    fprintf('\n%s\n',RefElement.name);

    npt = size(X,1); ndof = npt;

    % System of equations 
    [K,f] = BuildSystem(X,T,RefElement,Example);

    ndofT = size(K,1); 

    % Dirichlet boundary conditions
    C = ApplyDBCs(X,Example,1e-6); 

    % Apply Neumann Boundary conditions
    f = Neumann(f,X,Example,elementDegree);

    % Solution
    u = Solver(K,f,C); 


    % Exact displacement
    u_ex = ExactSol(X,Example);

    %L2 and H1 errors
    [errL2, errH1] = ComputeErrorsFEM(X,T,u,RefElement,Example);
    fprintf('\nL2 error = %0.2e    H1 error=%0.2e\n',errL2,errH1);
    L2u(i) = errL2;
    H1u(i) = errH1;
    sizeOfElem(i) = 1./nx;
    eval(sprintf('save(''Ex%d_BC%d_Elem%d_H%d_error.mat'',''L2u'',''H1u'')',exID,BC,elementType,elementDegree));
end
else
    filename = sprintf('Ex%d_BC%d_Elem%d_H%d_error.mat',exID,BC,elementType,elementDegree);
    load(filename);
end
figure(1);
plot(log10(sizeOfElem),log10(L2u),'*-','LineWidth', 2.5, 'MarkerSize', 12);
addTriangle(log10(flipud(sizeOfElem(:))),log10(flipud(L2u(:))),'k');
xlabel('log$_{10}$($h$)','Interpreter','latex','FontName','cmr12')
ylabel('log$_{10}(||E||_{L^2(u)})$','Interpreter','latex','FontName','cmr12');
set(gca,'FontSize',26,'FontName','cmr12','TickLabelInterpreter','latex');
eval(sprintf('saveas(gcf,''Ex%d_BC%d_Elem%d_H%d_L2u.png'')',exID,BC,elementType,elementDegree));
figure(2);
plot(log10(sizeOfElem),log10(H1u),'*-','LineWidth', 2.5, 'MarkerSize', 12);
addTriangle(log10(flipud(sizeOfElem(:))),log10(flipud(H1u(:))),'k');
xlabel('log$_{10}$($h$)','Interpreter','latex','FontName','cmr12')
ylabel('log$_{10}(||E||_{H^1(u)})$','Interpreter','latex','FontName','cmr12');
set(gca,'FontSize',26,'FontName','cmr12','TickLabelInterpreter','latex');
eval(sprintf('saveas(gcf,''Ex%d_BC%d_Elem%d_H%d_H1u.png'')',exID,BC,elementType,elementDegree));
