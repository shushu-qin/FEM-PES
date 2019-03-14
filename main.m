% This program solves a 2D Poisson Problem for linear and quadratic
% triangles and quadrilaterals
clear all; close all; %clc

setpath;

Example = SetExample();

elementType = 0;
elementDegree = 1;
dom = Example.dom;
nx = 10;
ny = 10;

[X,T] = createRectangleMesh(dom,elementType,elementDegree,nx,ny);

RefElement = ReferenceElement(elementType,elementDegree);
fprintf('\n%s\n',RefElement.name);

npt = size(X,1); ndof = npt;

% System of equations 
[K,f] = BuildSystem(X,T,RefElement,Example);

%ndofT = size(K,1); 
%  Apply Neumann Boundary conditions
% g = 1;
% Nborder = NeumannFaces(X,1);
% fe = zeros(2,1);
% for i = 1:(size(Nborder,1)-1)
%     length = Nborder(i+1,2:3)-Nborder(i,2:3);
%     Xb = (Nborder(i+1,2:3)+Nborder(i,2:3))/2;
%     fe = fe + NBC(Xb,Example)*length/2*[1,1]';
%     f(Nborder(i,1))= fe(1);
%     f(Nborder(i+1,1))= fe(2);
% end


% Dirichlet boundary conditions
C = ApplyDBCs(X,Example,1e-6); 

% Solution
u = Solver(K,f,C); 

% Exact displacement
u_ex = ExactSol(X,Example);

% % Exact and numerical displacement
% figure; clf; hold on
% trisurf(T,X(:,1),X(:,2),u(:,1)); 
% trisurf(T,X(:,1),X(:,2),u_ex,'r');
% box on; axis equal tight;
% set(gca, 'FontSize', 16);

% Plot of u
figure; 
trisurf(T,X(:,1),X(:,2),u(:,1)); 
title('u','FontSize',12)

%L2 and H1 errors
[errL2, errH1] = ComputeErrorsFEM(X,T,u,RefElement,Example);
fprintf('\nL2 error = %0.2e    H1 error=%0.2e\n',errL2,errH1);
WritingFile(X,T,u,u_ex);
