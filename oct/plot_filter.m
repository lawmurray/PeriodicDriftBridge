function plot_filter
  ax = [0 90 -5 4];
  ps = [];
  filters = {'Bootstrap'; 'Bridge'};

  for i = 1:length(filters);
      subplot(1, length(filters), i);
      bi_plot_paths(sprintf('results/filter_%s.nc', tolower(filters{i})), ...
                    'v', [], ps, [], i);
      hold on;
      bi_plot_paths('data/obs_set.nc', 'v');
      hold off;
      axis(ax);
      xlabel('t');
      if i == 1
          ylabel('x/\pi');
      end
      legend(filters{i}, 'location', 'northwest');
      legend('boxoff');
      grid on;
    end
end
