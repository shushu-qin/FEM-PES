function res = Neumann(f,X,Example,elementDegree)
inflowEdges = Example.inflowEdges;
outflowEdges = Example.outflowEdges;
for j = 1:2
    if j==1
        Nborder = inflowEdges;
        g = -1;
    elseif j==2
        Nborder = outflowEdges;
        g = 1;
    end
    if elementDegree ==1
        for i = 1:(size(Nborder,1))
            fe = zeros(2,1);
            X1 = X(Nborder(i,1),:);
            X2 = X(Nborder(i,2),:);
            shapeFun = ShapeFunc1D(elementDegree);
            zgp = shapeFun.zgp; 
            wgp = shapeFun.wgp; 
            N = shapeFun.N; 
            Nxi =shapeFun.Nxi;
            lengthSide = norm(X2-X1);
            Xe = [X1;X2];
            for ig = 1:length(wgp)
                N_ig    = N(ig,:);
                Nxi_ig    = Nxi(ig,:);
                %Jacobian matrix
                J = lengthSide/2; %Jacobian in 1D             
                dlength=wgp(ig)*J;
                fe = fe + g*N_ig'*dlength;
            end
            indx = Nborder(i,:);
            f(indx)= f(indx) + fe;
        end
    elseif elementDegree == 2
        for i = 1:length(Nborder)
            fe = zeros(3,1);
            X1 = X(Nborder(i,1),:);
            X2 = X(Nborder(i,2),:);
            X3 = X(Nborder(i,3),:);
            lengthSide = norm(X3-X1);
%             Xb = (Nborder(i+1,2:3)+Nborder(i,2:3))/2;
            shapeFun = ShapeFunc1D(elementDegree);
            zgp = shapeFun.zgp; 
            wgp = shapeFun.wgp; 
            N = shapeFun.N; 
            Nxi =shapeFun.Nxi;

            Xe = [X1;X2;X3];
            xe = Xe(:,1); ye = Xe(:,2);
            for ig = 1:length(wgp)
                N_ig    = N(ig,:);
                Nxi_ig    = Nxi(ig,:);
                %Jacobian matrix
                J = Nxi_ig*Xe; %Jacobian in 1D  
                dlength=wgp(ig)*norm(J);
                fe = fe + g*N_ig'*dlength;
            end
            indx = Nborder(i,:);
            f(indx)= f(indx) + fe;

        end
    end
end
res = f;