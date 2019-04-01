% Politecnical University of Catalunya
% Course name: Programming for Engineers and Scientists
% Students: Raul Bravo Shushu QinArthur Lustman Marina Vilardell
% Program to solve a Poisson equation problem in a fluid using the FEM 
% (Finite Element Method)
% 
% Input Data: - Geometry of the Mesh (X,T)
%             - Boundary conditions (inFlowEdges,outFlowEdges,zeroNodes)
%             - Material proprerty equation k
% Output Data:  - Plot of u
%               - Plot of velocity vectors of gradient of u
%               - Creation of a .vtk file to visualize the results in Paraview (createVTK)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% triangles and quadrilaterals
clear all; close all; %clc

setpath;
scratchfolder = 'plots' % scratch folder to save the plots
exID = 1;
elementType = 1; % elementType: 0 for quadrilateral and 1 for triangles
elementDegree =1;
k = @(x,y) 1-3.95*y^2;
kk = 99; % 99: function

file_name = 'meshHW1c.mat';
load(file_name);
Example = SetExample(exID,zeroNodes,inflowEdges,outflowEdges,k);

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

% Plot of u
figure(1); 
plotU(elementType,elementDegree,X,T,u); 
alpha(0.8);
caxis([-1 1]);
eval(sprintf('saveas(gcf,''%s/Ufield_k%d_P1.png'')',scratchfolder,kk));
% Vector Plot of gradient of u
figure(2);
[Xcenter ux uy] = GradU(X,T,RefElement,Example,u);
PlotMesh(T,X,elementType,'k-');
hold on;
scalefactor = 0.05;
plotVector(scalefactor,Xcenter,ux,uy);
eval(sprintf('saveas(gcf,''%s/vectorGradU_k%d_P1.png'')',scratchfolder,kk));

% write vtk file for paraview
mat2vtk(u,[ux,uy],T,X);
