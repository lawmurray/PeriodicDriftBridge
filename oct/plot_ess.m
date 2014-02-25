function plot_ess(rep)
    if nargin == 0
        rep = 0;
    end
    
    y = [];
    filters = {'Bootstrap'; 'Bridge'};
    for i = 1:length(filters)
        file = sprintf('results/test_%s-%d.nc', tolower(filters{i}), rep);
        nc = netcdf(file, 'r');
        P = nc{'P'}(:);
        L = nc{'loglikelihood'}(:,:)';
        metric = ess(L)'/rows(L);
        y = [ y metric ];
        ncclose(nc);
    end


    % plot bars
    h = bar (log2(P), y);
    for i = 1:length(h)
        set (h(i), 'facecolor', fade(watercolour(i), 0.5));
        set (h(i), 'edgecolor', watercolour(i));
    end
end
