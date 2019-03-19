function du = NBC(X, Example)
    x = X(1);
    y = X(2);
    du = zeros(2,1);
    if Example.ID == 1
        du(1) = 1;
        du(2) = 1;
    elseif Example.ID == 2
          du(1) = (1./2000)*dh(X(:,1)).*h(X(:,2));
          du(2) = (1./2000)*h(X(:,1)).*dh(X(:,2));
    elseif Example.ID == 3
        du(1) = (y-0.5)*cos(x-0.5)+sin(y-0.5);
        du(2) = sin(x-0.5)+(x-0.5)*cos(y-0.5);
    end
end

function y=h(x)
y = (x.^2).*((1-x).^2).*exp(10*x);
end

function y=dh(x)
y = 2*x.*exp(10.*x).*(x - 1).^2 + x.^2.*exp(10.*x)*(2.*x - 2) ...
    + 10.*x^2.*exp(10.*x).*(x - 1)^2;
end