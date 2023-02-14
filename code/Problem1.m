X = [0.1000, 0.8225, 1.5450, 2.2675, 2.9900];
Y = [1.3438, 1.8667, 0.3690, 1.6426, 1.5516];
syms x

P(x) = Lagrange(x, X, Y);
G(x) = exp(sin(3*x));
E(x) = abs(P(x) - G(x));

t = linspace(0, 3);

subplot(2, 1, 1)
plot(t, G(t))
hold on
plot(t, P(t))
plot(X, Y, 'bo')
title('exp(sin(3x)) and its corresponding Lagrange polynomial')
legend('Original function', 'Interpolated polynomial', 'Given points')

subplot(2, 1, 2)
plot(t, E(t))
title('The error between the given function and its Lagrange polynomial')

hold off