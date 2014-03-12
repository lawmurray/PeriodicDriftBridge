function plot_filter
  ax = [0 90 -5 4];
  ps = [];
  filters = {'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      file = sprintf('results/filter_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      bi_plot_paths(file, 'v', [], ps, [], i);
      hold on;
      
      nc = netcdf(file, 'r');
      t = nc{'time'}(:);
      A = nc{'ancestor'}(:,:)';
      for j = 1:columns(A)
          if sum(A(:,j) != [0:(rows(A)-1)]') > 0
              % resampling occurred at this point
              line([t(j) t(j)], [ax(3) ax(4)], 'color', 'k');
              %t
          end
      end
      ncclose(nc);
      
      bi_plot_paths('data/obs_set.nc', 'v');
      hold off;
      axis(ax);
      title(filters{i});
      xlabel('t');
      if i == 1
          ylabel('x/\pi');
      end
      grid on;
    end
end
