function g = NBC(X, Example)
    x = X(1);
    y = X(2);
    if Example.ID == 1
        g = 1;
    elseif Example.ID == 2
        if abs(y-1)<1.e-6
            g = 1;
        elseif abs(y)<1.e-6
            g = 1;
        end
    end
end