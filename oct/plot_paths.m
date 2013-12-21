function plot_paths()
    ax = [0 90 -4 2];
    range = [32:32:1024];
    filters = {'Bootstrap'; 'Bridge'};
    
    for i = 1:length(filters);
        subplot(1, length(filters), i);
        bi_plot_paths(sprintf('results/posterior_%s.nc', tolower(filters{i})), 'v', [], range);
        hold on;
        bi_plot_paths('data/obs_set.nc', 'v');
        hold off;
        axis(ax);
        xlabel('t');
        if i == 1
            ylabel('x/\pi');
        end
        title(filters{i});
    end
end
