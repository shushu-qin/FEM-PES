function u = ExactSol(X,Example)
% 
% u = exactSol(x,y,example)
% u : solution
u = zeros(size(X,1),1);
u_x = zeros(size(X,1),1);
u_y = zeros(size(X,1),1);
if Example.ID == 1
    u = X(:,1) + X(:,2);
    u_x = ones(size(X,1),1);
    u_y = ones(size(X,1),1);
elseif Example.ID == 2
    u = (1./2000)*h(X(:,1)).*h(X(:,2));
    
elseif Example.ID == 3
    x = X(:,1); y = X(:,2);
    u = (y-0.5).*sin(x-0.5)+(x-0.5).*sin(y-0.5);

end
end
     
function y=h(x)
y = (x.^2).*((1-x).^2).*exp(10*x);
end

function y=dh(x)
y = 2*x.*exp(10.*x).*(x - 1).^2 + x.^2.*exp(10.*x)*(2.*x - 2) ...
    + 10.*x^2.*exp(10.*x).*(x - 1)^2;
end

