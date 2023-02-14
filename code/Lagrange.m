function P = Lagrange(x, X, Y)
    % X and Y are the points for which Lagrange interpolation is done.
    P = 0;
    n = length(X);
    for i = 1:n
        P = P + f(x, X, i)*Y(i);
    end
end