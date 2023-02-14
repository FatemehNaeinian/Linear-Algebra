function result = f(x, c, i)
    % c is the set of points for which f_i(x) is formed.
    result = 1;
    n = length(c);
    for j = 1:n
        if j == i
            continue
        end
        result = result .* (x - c(j)) ./ (c(i) - c(j));
    end
end