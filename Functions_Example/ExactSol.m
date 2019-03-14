function [u,u_x,u_y] = ExactSol(X,Example)
% 
% [u,u_x,u_y] = exactSol(x,y,example)
% u : solution
% u_x : derivatives with respect to x
% u_y : derivatives with respect to y

u = zeros(size(X,1),1);
u_x = zeros(size(X,1),1);
u_y = zeros(size(X,1),1);
if Example.ID == 1
    u = X(:,1) + X(:,2);
    u_x = ones(size(X,1),1);
    u_y = ones(size(X,1),1);
elseif Example.ID == 2
    for i = 1:size(X,1)
        x = X(i,1);
        y = X(i,2);
        u(i) = ufunction(x,y);
        u_x(i) = dufunction_x(x,y);
        u_y(i) = dufunction_y(x,y);
    end
end

function res = ufunction(x,y)
 if y == 0
     res = sin(pi*x);
 elseif x == 0 || x == 1 || y == 1
     res = 0;
 else
     res = sin(pi*x)*(cosh(pi*y) - coth(pi*y)*sinh(pi*y));
 end
 
 function res = dufunction_x(x,y)
 if y == 0
     res = pi*cos(pi*x);
 elseif x == 0 || x == 1 || y == 1
     res = 0;
 else
     res = pi*cos(pi*x)*(cosh(pi*y) - coth(pi*y)*sinh(pi*y));
 end
 
  function res = dufunction_y(x,y)
 if y == 0
     res = 0;
 elseif x==0 || x == 1 || y == 1
     res = 0;
 else
     %res = sin(pi*x)*((csch(pi*x)^2+1)*sinh(pi*x)-cosh(pi*x)*coth(pi*x));
     res = pi*sin(pi*x)*(sinh(pi*y) - (cosh(pi*y)*coth(pi*y)-((csch(pi*y))^2)*sinh(pi*y)));
end
     
     

