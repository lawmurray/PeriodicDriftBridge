function l = f(theta, t, x)
    sigma2 = exp(theta(1));
    epsilon = exp(theta(2));

    Z = sqrt(2*pi*sigma2*t).*(exp(-sigma2*t/2) + 1 + epsilon);
    l = (cos(x) + 1 + epsilon).*exp(-x.^2./(2*sigma2*t))./Z;
end
