% Universitat PolitËcnica de Catalunya - Barcelona Tech
% Module: Programming for Engineers and Scientists
% Students: Marina Vilardell, Shushu Qin, Arthur Lustman, Raul Bravo
% Program to solve a Poisson equation problem in a fluid using the FEM 
% (Finite Element Method)
% 
% Input Data: - Geometry of the Mesh (X,T)
%             - Boundary conditions (inFlowEdges,outFlowEdges,zeroNodes)
%             - Material property equation k
% Output Data:  - Plot of u, pressure
%               - Plot of gradient of u, velocity vectors 
%               - Creation of a .vtk file to visualize the results in Paraview (createVTK)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc

% Requesting input from user
disp(' ')
disp('      FLOW PROBLEM     ')
disp('The following elements are available')
disp('         [1]: Linear Triangles   [2]: Quadratic Triangles')
elementDegree = input('Choose the element for the solution :  ');
if elementDegree ==2
    file_name = 'meshHW1cquad.mat';
elseif elementDegree==1
    file_name = 'meshHW1c.mat';     
else
    error('SELECTION NOT VALID')
end


setpath;
scratchfolder = 'plots'; % scratch folder to save the plots
exID = 1;
elementType = 1; % elementType: 0 for quadrilateral and 1 for triangles


%Equation for the material parameters k
k = @(x,y) 1-3.95*y^2;

%For the saved plots, the following reference is used 
% 99: Default given function. 
%Add another reference if you modify the material parameter k
kk = 99; 


load(file_name);
Example = SetExample(exID,zeroNodes,inflowEdges,outflowEdges,k);

RefElement = ReferenceElement(elementType,elementDegree);
fprintf('\n%s\n',RefElement.name);

npt = size(X,1); ndof = npt;

% System of equations 
[K,f] = BuildSystem(X,T,RefElement,Example);

ndofT = size(K,1); 


% Dirichlet boundary conditions
C = ApplyDBCs(X,Example); 

% Apply Neumann Boundary conditions
f = Neumann(f,X,Example,elementDegree);

% Solution
u = Solver(K,f,C); 

% Plot of u
figure(1); 
plotU(elementType,elementDegree,X,T,u); 
alpha(0.8);
caxis([-1 1]);
eval(sprintf('saveas(gcf,''%s/Ufield_k%d_P%d.png'')',scratchfolder,kk,elementDegree));
% Vector Plot of gradient of u
figure(2);
[ux uy] = GradU(X,T,RefElement,Example,u);

hold on;
scalefactor = 0.05;
plotVector(scalefactor,X,ux,uy);
title 'Velocity Vectors'
PlotMesh(T,X,elementType,'k-'); 
eval(sprintf('saveas(gcf,''%s/vectorGradU_k%d_P%d.png'')',scratchfolder,kk,elementDegree));


% write vtk file for paraview
mat2vtk(u,[ux,uy],T,X,elementDegree);
