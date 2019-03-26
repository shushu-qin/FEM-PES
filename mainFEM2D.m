% This program solves a 2D Poisson Problem for linear and quadratic
% triangles and quadrilaterals
clear all; close all; %clc

setpath;

exID = 1;
elementType = 0; % elementType: 0 for quadrilateral and 1 for triangles
elementDegree = 1;
% BC = 2; % 1: all Dirichlet; 2: top-bottom Neumann
% nx = 2;
% ny = 2;


% [X,T] = createRectangleMesh(dom,elementType,elementDegree,nx,ny);
file_name = cinput('Name of the mesh file: ','example1.mat'); 
load(file_name);
Example = SetExample(exID,zeroNodes,inflowEdges,outflowEdges);

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

% % Exact and numerical displacement
% figure; clf; hold on
% trisurf(T,X(:,1),X(:,2),u_ex(:,1),'r');
% box on; axis equal tight;
% set(gca, 'FontSize', 16);

% Plot of u
figure(1); 
plotU(elementType,elementDegree,X,T,u); 

% Plot of u_ex
figure(2);
plotU(elementType,elementDegree,X,T,u_ex);  
title('u_ex','FontSize',12)

%L2 and H1 errors
[errL2, errH1] = ComputeErrorsFEM(X,T,u,RefElement,Example);
fprintf('\nL2 error = %0.2e    H1 error=%0.2e\n',errL2,errH1);
WritingFile(X,T,u,u_ex);
