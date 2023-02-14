function [U, S, V] = my_svd(A)
    [U, S1] = eig(A*A');
    [V, S2] = eig(A'*A);
    n = size(A);
    n = n(1);
    % Eigenvalues of AA' and A'A, as row matrices.
    lambda1 = ones(1, n) * S1;
    lambda2 = ones(1, n) * S2;
    % Sort U, S, V such that the singular values are in descending order.
    [lambda1, i1] = sort(lambda1, 'descend');
    [~, i2] = sort(lambda2, 'descend');
    U = U(:, i1);
    V = V(:, i2);
    % Singular values are the square roots of A'A lambdas.
    S = sqrt(diag(lambda1));
    % Some U columns might need to be multiplied by -1.
    S2 = U'*A*V;
    for i = 1:n
        if S2(i, i) < 0
            U(:, i) = -U(:, i);
        end
    end
end