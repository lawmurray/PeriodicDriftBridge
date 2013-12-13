function prepare_obs
    % creates obs as in Lin, Chen and Mykland (2010), Figure 4
    nc = netcdf('data/obs_set.nc', 'c');
    nc('nr') = 4;
    nc{'time'} = ncdouble('nr');
    nc{'y'} = ncdouble('nr');
    nc{'time'}(:) = [0 30 60 90]';
    nc{'y'}(:) = [0 1.49 -5.91 -1.17]';
    ncclose(nc);
end
