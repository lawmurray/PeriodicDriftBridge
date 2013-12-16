function nll = cost(theta, t, x)
    l = f(theta, t, x);
    nll = -sum(log(l));
end
