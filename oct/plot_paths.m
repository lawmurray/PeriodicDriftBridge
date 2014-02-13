function plot_paths()
    ax = [0 90 -5 4];
    range = [64:64:1024];
    filters = {'Bootstrap'; 'Bridge'};
    
    for i = 1:length(filters);
        subplot(1, length(filters), i);
        bi_plot_paths(sprintf('results/posterior_%s.nc', tolower(filters{i})), ...
                      'v', [], range, [], i);
        hold on;
        bi_plot_paths('data/obs_set.nc', 'v');
        hold off;
        axis(ax);
        xlabel('t');
        ylabel('x/\pi');
        %title(filters{i});
        legend(filters{i}, 'location', 'northwest');
        grid on;
    end
end
