function du = NBC(X, Example)
    x = X(1);
    y = X(2);
    du = zeros(2,1);
    if Example.ID == 1
        du(1) = 1;
        du(2) = 1;
    elseif Example.ID == 2
%         u_x = -1/2000*( 8*exp(10*x)*(125*x^4-100*x^3-55*x^2+33*x+6)*...
%               y^2*(1-y)^2*exp(10*y)+(2+28*y-8*y^2-120*y^3+100*y^4)*exp(10*y)*...
%               2*exp(10*x)*x*(5*x^3-8*x^2+2*x+1));
%         u_y =  -1/2000*(8*exp(10*y)*(125*y^4-100*y^3-55*y^2+33*y+6)*...
%               x^2*(1-x)^2*exp(10*x)+(2+28*x-8*x^2-120*x^3+100*x^4)*exp(10*x)*...
%               2*exp(10*y)*x*(5*y^3-8*y^2+2*y+1));
% u = (1./2000)*h(X(:,1)).*h(X(:,2));
          du(1) = (1./2000)*dh(X(:,1)).*h(X(:,2));
          du(2) = (1./2000)*h(X(:,1)).*dh(X(:,2));
%     elseif Example.ID == 3
%         u_x = 2*pi*sin(2*pi*x).*sin(2*pi*y);
%         u_y = -2*pi*cos(2*pi*y).*(cos(2*pi*x) - 1);
%         g = -u_y;
    end
end

function y=h(x)
y = (x.^2).*((1-x).^2).*exp(10*x);
end

function y=dh(x)
y = 2*x.*exp(10.*x).*(x - 1).^2 + x.^2.*exp(10.*x)*(2.*x - 2) ...
    + 10.*x^2.*exp(10.*x).*(x - 1)^2;
end