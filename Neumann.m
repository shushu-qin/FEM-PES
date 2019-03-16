function res = Neumann(f,X,Example)
NBCs = Example.NBC;
for j = 1:length(NBCs)
    g = NBCs(j);
    if g ~=0
        switch j
            case 1
                n = [0,-1];
            case 2
                n = [1,0];
            case 3
                n = [0,1];
            case 4
                n = [-1,0];
        end
        fe = zeros(2,1);
        Nborder = NeumannFaces(X,j);
        for i = 1:(size(Nborder,1)-1)
            lengthSide = norm(Nborder(i+1,2:3)-Nborder(i,2:3));
            
            Xb = (Nborder(i+1,2:3)+Nborder(i,2:3))/2;
            fe = fe + n*NBC(Xb,Example)*lengthSide/2;
            
            f(Nborder(i,1))= f(Nborder(i,1)) + fe(1);
            f(Nborder(i+1,1))= f(Nborder(i+1,1)) + fe(2);
        end
    end
end
res = f;