function u = Solver(K,f,C)

dofT = size(K,1); 
npt = dofT; 

dofDir = C(:,1); 
valDir = C(:,2); 

dofUnk = setdiff(1:dofT, dofDir); 

fred = f(dofUnk) - K(dofUnk,dofDir)*valDir;
Kred = K(dofUnk, dofUnk); 
%fred = f(dofUnk); 
sol = Kred\fred; 

u = zeros(dofT,1); 
u(dofUnk) = sol; 
u(dofDir) = valDir;

end


% % Using Lagrange multipliers
% nDir = size(C,1); 
% dofT = size(K,1); 
% npt = dofT/2; 
% 
% Accd = spalloc(nDir,ndof,nDir); 
% Accd(:,C(:,1)) = eye(nDir);  
% bccd = C(:,2); 
% 
% Atot = [K       Accd'                      
%        Accd    spalloc(nDir,nDir,1) ];
% btot = [f; bccd];
% 
% aux = Atot\btot;
% 
% u = reshape(aux(1:ndofT),2,npt)';
