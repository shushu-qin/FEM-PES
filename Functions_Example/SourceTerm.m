function s = SourceTerm(X,Example)
x = X(1); y = X(2);

if Example.ID== 1
    s = 0;
elseif Example.ID== 2
    x=X(:,1); y=X(:,2);
    s = -(1/2000)*(ddh(x).*h(y)+h(x).*ddh(y));
% elseif Example.ID== 3
%     s=4*pi^2*cos(2*pi*x)*sin(2*pi*y) + 4*pi^2*sin(2*pi*y)*(cos(2*pi*x) - 1);
end

function y=ddh(x)
y = (2+28*x-8*x.^2-120*x.^3+100*x.^4).*exp(10*x);

function y=h(x)
y = (x.^2).*((1-x).^2).*exp(10*x);