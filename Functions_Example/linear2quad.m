function [X, T, Example] = linear2quad(X,T,Example)

inflow = Example.inflowEdges;
outflow = Example.outflowEdges;
inflow(end,end+1) = 0;
outflow(end,end+1) = 0;
tol = 1E-6;
T(end,end+3) = 0;
n = length(T);
m = length(X);
nodeId = length(X)+1;
pair = [[1,2];[2,3];[3,1]];
for i = 1:n
    xLocal = X(T(i,1:3),:);      
    for j = 1:3
        xCoord = xLocal(pair(j,1),1) + xLocal(pair(j,2),1);
        yCoord = xLocal(pair(j,1),2) + xLocal(pair(j,2),2);
        coord = [xCoord/2,yCoord/2];
        small = 1;
        k = m;
        while small>tol && k<nodeId
            k = k + 1;
            small = min(small,abs(norm(coord-X(k-1,:))));
        end
        if small>tol
            X(nodeId,:) = coord;
            T(i,3+j) = nodeId;
            nodeId = nodeId + 1;
        else
            T(i,3+j) = k-1;
        end
        
        %to split the faces inflow
        for index = 1:length(inflow)
            if inflow(index,1)==T(i,pair(j,1)) && inflow(index,2)==T(i,pair(j,2))
                inflow(index,3) = inflow(index,2);
                inflow(index,2) = T(i,3+j);
                break
            end
            if inflow(index,1)==T(i,pair(j,2)) && inflow(index,2)==T(i,pair(j,1))
                inflow(index,3) = inflow(index,2);
                inflow(index,2) = T(i,3+j);
                break
            end
        end
        
        %to split the faces outflow
        for index = 1:length(outflow)
            if outflow(index,1)==T(i,pair(j,1)) && outflow(index,2)==T(i,pair(j,2))
                outflow(index,3) = outflow(index,2);
                outflow(index,2) = T(i,3+j);
            end
            if outflow(index,1)==T(i,pair(j,2)) && outflow(index,2)==T(i,pair(j,1))
                outflow(index,3) = outflow(index,2);
                outflow(index,2) = T(i,3+j);
            end
        end
    end
end
Example.inflowEdges = inflow;
Example.outflowEdges = outflow;