function plot_weight
  Y_RES = 400;

  ax = [0 30 -3 3];

  subplot(1,2,1);
  bi_image_density('results/prepare_input.nc', 'v', [], [], [], Y_RES);
  xlabel('t');
  ylabel('x/\pi');
  
  axis(ax);
  cax = caxis();
  
  t = linspace(0, ax(2), 401);
  x = linspace(ax(3), ax(4), Y_RES)*pi;
  
  nc = netcdf('data/input.nc', 'r');
  theta = [log(nc{'sigma2'}(:)) log(nc{'epsilon'}(:))]';
  ncclose(nc);
  
  [tt, xx] = meshgrid(t, x);
  pp = f(theta, tt, xx);
  mx = max(pp);
  pp = pp./repmat(mx, rows(pp), 1);
    
  subplot(1,2,2);
  imagesc(t, x/pi, pp);
  set(gca(), 'ydir', 'normal');
  axis(ax);
  caxis(cax);
  xlabel('t');
  ylabel('x/\pi');
end
