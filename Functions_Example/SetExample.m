function example = SetExample(exID,zeroNodes,inflowEdges,outflowEdges)
% 
% example = SetExample()
% Domain description, material properties


example.k = @(x,y) 1-3.95*y^2;
% example.k = @(x,y) 1;
example.ID = exID;

example.zeroNodes = zeroNodes;
example.inflowEdges = inflowEdges;
example.outflowEdges = outflowEdges;    


