function Nborder = NeumannFaces(X,condition)
% condition [5 cases]; 0 no Neumann, [1] y=0, [2] x=1, [3] y=1, [4] x=0
preborder = [linspace(1,length(X),length(X))',X];
Nborder = [];
tol = 1E-6;
if condition == 1
    for i = 1:length(X)
        if abs(X(i,2)) < tol
            Nborder = [Nborder; preborder(i,:)];
        end
    end
elseif condition == 2
    for i = 1:length(X)
        if abs(X(i,1)-1) < tol
            Nborder = [Nborder; preborder(i,:)];
        end
    end
elseif condition == 3
    for i = 1:length(X)
        if abs(X(i,2)-1) < tol
            Nborder = [Nborder; preborder(i,:)];
        end
    end
elseif condition == 4
    for i = 1:length(X)
        if abs(X(i,1)) < tol
            Nborder = [Nborder; preborder(i,:)];
        end
    end
end