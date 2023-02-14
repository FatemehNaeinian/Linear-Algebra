function S2 = selectSingularValues(S, k)
    n = size(S);
    n = n(1);
    S2 = S * [eye(k), zeros(k, n-k); zeros(n-k, n)];
end