function prepare_init
  nc = netcdf('data/init.nc', 'c');
  nc{'theta'} = ncdouble();
  nc{'theta'}(:) = pi;
  ncclose(nc);
end
