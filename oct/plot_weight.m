function plot_weight
  Y_RES = 500;

  ax = [0 30 -3 3];
  lambda = 1/4; % tempering

  subplot(1,3,1);
  bi_image_density('results/prepare_input.nc', 'v', [], [], [], Y_RES);
  xlabel('t');
  ylabel('x/\pi');
  
  axis(ax);
  axis('normal');
  cax = caxis();
  
  t = linspace(0, ax(2), 401);
  x = linspace(ax(3), ax(4), Y_RES)*pi;
  
  nc = netcdf('data/input.nc', 'r');
  theta = [log(nc{'sigma2'}(:)) log(nc{'epsilon'}(:))]';
  ncclose(nc);
    
  [tt, xx] = meshgrid(t, x);
  
  pp1 = f(theta, tt, xx);
  mx1 = max(pp1);
  pp1 = pp1./repmat(mx1, rows(pp1), 1);

  pp2 = f(theta, tt, xx).^lambda;
  mx2 = max(pp2);
  pp2 = pp2./repmat(mx2, rows(pp2), 1);

  subplot(1,3,2);
  imagesc(t, x./pi, pp1);
  set(gca(), 'ydir', 'normal');
  axis(ax);
  axis('normal');
  caxis(cax);
  xlabel('t');

  subplot(1,3,3);
  imagesc(t, x./pi, pp2);
  set(gca(), 'ydir', 'normal');
  axis(ax);
  axis('normal');
  caxis(cax);
  xlabel('t');
end
