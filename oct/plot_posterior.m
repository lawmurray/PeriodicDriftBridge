function plot_posterior
  ax = [0 90 -5 4];
  ps = [1:16:1024];
  filters = {'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      file = sprintf('results/posterior_%s.nc', tolower(filters{i}));
      subplot(1, length(filters), i);
      bi_plot_paths(file, 'v', [], ps, [], i);
      hold on;
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
