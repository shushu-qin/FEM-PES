function example = SetExample(exID,dom,zeroNodes,inflowEdges,outflowEdges)
% 
% example = SetExample()
% Domain description, material properties


example.k = @(x,y) 1-3.95*y^2;
example.ID = exID;
example.dom = dom;

example.zeroNodes = zeroNodes;
example.inflowEdges = inflowEdges;
example.outflowEdges = outflowEdges;    


