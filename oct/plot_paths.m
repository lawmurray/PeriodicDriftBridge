function plot_paths()
    ax = [0 90 -4 2];
    
    subplot(1,2,1);
    bi_plot_paths('results/posterior_bootstrap.nc', 'v', [], [32:32:1024]);
    hold on;
    bi_plot_paths('data/obs_set.nc', 'v');
    hold off;
    axis(ax);
    xlabel('t');
    ylabel('x/\pi');
    
    subplot(1,2,2);
    bi_plot_paths('results/posterior_bridge.nc', 'v', [], [32:32:1024]);
    hold on;
    bi_plot_paths('data/obs_set.nc', 'v');
    hold off;
    axis(ax);
    xlabel('t');
end
