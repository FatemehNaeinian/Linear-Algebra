P = 'lfwcrop_grey/faces';
D = dir(fullfile(P,'*.pgm'));
n = 1000;
X = zeros(n, 64*64);
for k = 1:n
    X(k, :) = double(reshape(imread(fullfile(P,D(k).name)), 1, []));
end


[W, L] = eig(X'*X);
m = size(L);
m = m(1);
lambda = ones(1, m) * L;
[lambda, idx] = sort(lambda, 'descend');
W = W(:, idx);
cumulative = cumsum(lambda / sum(lambda));
figure
plot(cumulative)
title('cumulative variance for eigen values')

pictureToSee = 10;
kvalues = [40, 70, 150, 250, 500, m];
figure
for i = 1:length(kvalues)
    subplot(2, 3, i)
    F = diag([ones(1, kvalues(i)), zeros(1, m-kvalues(i))]);
    X_new = X * W * F * W';
    imshow(uint8(reshape(X_new(pictureToSee, :), 64, 64)))
    title(kvalues(i))
end
