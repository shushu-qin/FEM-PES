function example = SetExample(exID)
% 
% example = SetExample()
% Domain description, material properties


example.k = 1;
example.ID =exID;
example.dom = [0,1,0,1];

switch example.ID
    case 1
        example.DBC = [1,1,1,1];
        example.NBC = [0,0,0,0];
    case 3
        example.DBC = [0,1,0,1];
        example.NBC = [1,0,1,0];
        example.ID = 1;
    case 2
        example.DBC = [0,1,0,1];
        example.NBC = [1,0,1,0];
end
    


