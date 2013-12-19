function prepare_obs
    % creates obs as in Lin, Chen and Mykland (2010), Figure 4
    t = [0 30 60 90]';
    y = [0 1.49 -5.91 -1.17]';
    x = y;
    v = x/pi;
        
    nc = netcdf('data/obs_set.nc', 'c');
    nc('nr') = 4;
    nc{'time'} = ncdouble('nr');
    nc{'y'} = ncdouble('nr');
    nc{'x'} = ncdouble('nr');
    nc{'v'} = ncdouble('nr');
    nc{'time'}(:) = t;
    nc{'y'}(:) = y;
    nc{'x'}(:) = x;
    nc{'v'}(:) = v;
    ncclose(nc);
end
