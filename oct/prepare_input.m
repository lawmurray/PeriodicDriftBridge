function prepare_input
    % read data
    nc = netcdf('data/obs.nc', 'r');
    t = nc{'time'}(:);
    Y = nc{'y'}(:,:);
    N = columns(Y);
    ncclose(nc);
    
    % fit bridge weighting parameters
    ell2 = zeros(N, 1);
    sf2 = zeros(N, 1);
    epsilon = 1.0e-4;
    
    for i = 1:N
        y = Y(:,i);
        
        inffunc = @infExact;
        meanfunc = @meanZero;
        hyp.mean = [];
        covfunc = @covSEiso;
        hyp.cov = log([60; 8*pi]);
        likfunc = @likGauss;
        hyp.lik = log(epsilon);
        
        hyp = minimize(hyp, @gpwrap, -100, @infExact, meanfunc, covfunc, ...
                       likfunc, t, y);
        
        ell2(i) = exp(2.0*hyp.cov(1));
        sf2(i) = exp(2.0*hyp.cov(2));
    end
    
    % write bridge weighting parameters
    nc = netcdf('data/input.nc', 'c');
    nc('np') = N;
    nc{'ell2'} = ncdouble('np');
    nc{'sf2'} = ncdouble('np');
    nc{'epsilon'} = ncdouble();
    nc{'ell2'}(:) = ell2;
    nc{'sf2'}(:) = sf2;
    nc{'epsilon'}(:) = epsilon;
    ncclose(nc);
end
