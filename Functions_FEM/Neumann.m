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
        for i = 1:(size(Nborder,1)-1)
            fe = zeros(2,1);
            X1 = X(Nborder(i),:);
            X2 = X(Nborder(i+1),:);
            lengthSide = norm(X2-X1);
            nIntPoints = 1;
            shapeFun = ShapeFunc1D(elementDegree);
            zgp = shapeFun.zgp; 
            wgp = shapeFun.wgp; 
            N = shapeFun.N; 
            Nxi =shapeFun.Nxi;

            Xe = [X1;X2];
            xe = Xe(:,1); ye = Xe(:,2);
            for ig = 1:length(wgp)
                N_ig    = N(ig,:);
                Nxi_ig    = Nxi(ig,:);
                x_ig = N_ig*Xe;
                %Jacobian matrix
                J = lengthSide/2; %Jacobian in 1D             
                dlength=wgp(ig)*J;
                fe = fe + g*N_ig'*dlength;
            end
%             indx = Nborder(i,1):Nborder(i+1,1);
%             f(indx)= f(indx) + fe;
            indx1 = Nborder(i,1);
            indx2 = Nborder(i+1,1);
            f(indx1)= f(indx1) + fe(1);
            f(indx2)= f(indx2) + fe(2);
        end
    elseif elementDegree == 2
        for i = 1:2:size(Nborder,1)-2
            fe = zeros(3,1);
            lengthSide = norm(Nborder(i+1,2:3)-Nborder(i,2:3));
%             Xb = (Nborder(i+1,2:3)+Nborder(i,2:3))/2;
            nIntPoints = 1;
            shapeFun = ShapeFunc1D(elementDegree);
            zgp = shapeFun.zgp; 
            wgp = shapeFun.wgp; 
            N = shapeFun.N; 
            Nxi =shapeFun.Nxi;

            Xe = [Nborder(i,2:3);Nborder(i+1,2:3);Nborder(i+2,2:3)];
            xe = Xe(:,1); ye = Xe(:,2);
            for ig = 1:length(wgp)
                N_ig    = N(ig,:);
                Nxi_ig    = Nxi(ig,:);
                x_ig = N_ig*Xe;
                %Jacobian matrix
                J = Nxi_ig*Xe(:,1); %Jacobian in 1D             
                dlength=wgp(ig)*J;
                fe = fe + n*NBC(x_ig,Example)*N_ig'*dlength;
            end
            indx = Nborder(i,1):Nborder(i+2,1);
            f(indx)= f(indx) + fe;

        end
    end
end
res = f;