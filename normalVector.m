function n = normalVector(X1,X2)
n(1) = X1(2)-X2(2);
n(2) = -X1(1)+X2(1);
n = n/norm(n);