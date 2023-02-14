N = 10000;
N_train = 7000;
N_test = N - N_train;

x1 = normrnd(0, 1, [1, N]);
x2 = normrnd(0, 1, [1, N]);
x3 = x1 - x2 + normrnd(0, 1e-20, [1, N]);

X = [x1; x2; x3];
X_train = X(:, 1:N_train);
X_test = X(:, N_train+1:N);

y_x = [2, 3, -4];
y_train = y_x * X_train;

A = X_train';
b = y_train';

theta = (A'*A)\A' * b;
disp(theta)
%lsqr(X_train', y_train')

y_test = y_x * X_test;
[y_test, idx] = sort(y_test);
y_predict = theta' * X_test;
y_predict = y_predict(idx);
subplot(2, 2, 1)
plot(y_test, 'c.')
hold on
plot(y_predict, 'r--')
hold off
title('Prediction using pseudo-inverse')

% QR decomposition
[d, n] = size(A);
R = zeros(n, n);
Q = zeros(d, n);
for i = 1:n
    v = A(:,i);
    for j = 1:i-1
        R(j,i) = Q(:,j)'*v;
        v = v-R(j,i)*Q(:,j);
    end
    R(i,i) = norm(v);
    Q(:,i) = v/R(i,i);
end
disp(det(R))
theta2 = R\Q'*b;
subplot(2, 2, 2)
y_predict2 = theta2' * X_test;
y_predict2 = y_predict2(idx);
plot(y_test, 'c.')
hold on
plot(y_predict2, 'r--')
hold off
title('Prediction using QR')

subplot(2, 2, 3)
plot(abs(y_predict - y_test))
title('Error of pseudo-inverse method')
subplot(2, 2, 4)
plot(abs(y_predict2 - y_test))
title('Error of QR method')