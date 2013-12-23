function prepare_input
    pkg load optim;
    
    % read prior sample
    nc = netcdf('results/prepare_input.nc', 'r');
    X = nc{'x'}(:,:);
    T = repmat(nc{'time'}(:)', columns(X), 1)';
    ncclose(nc);
    
    theta = [log(1.0) log(0.1)]';
    x = X(:);
    t = T(:);
    is = find(t > 0);
    x = x(is);
    t = t(is);

    args = { theta; t; x; };
    [theta0, nll, nsteps] = nelder_mead_min('cost', args);
    
    % write bridge weighting parameters
    nc = netcdf('data/input.nc', 'c');
    nc{'sigma2'} = ncdouble();
    nc{'sigma2'}(:) = exp(theta0(1));
    nc{'epsilon'} = ncdouble();
    nc{'epsilon'}(:) = exp(theta0(2));
    ncclose(nc);
end
