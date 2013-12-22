function plot_metric(k)
    if nargin < 1
        k = 1;
    end
    
    filters = {'Bootstrap'; 'Bridge'};
    Ps = 2.**[3:8]';

    y = [];
    ly = [];
    uy = [];
    
    for i = 1:length(filters)
        metric = [];
        t = [];
        for j = 1:length(Ps)
            P = Ps(j);
            file = sprintf('%s%d.csv', tolower(filters{i}), P);
            %X = dlmread(file);
            % ^ dlmread doesn't handle the headers with spaces
            X = textread(file, '%f', inf, 'headerlines', 1);
            X = reshape(X, 6, length(X)/6)';
            X = X(2:end,:);
            % ^ ignore first row, as headers, and second, as time is outlier
            metric = [ metric X(:,k) ];
            t = [ t X(:,6) ];
        end            

        y = [ y quantile(metric, 0.5)' ];
        ly = [ ly quantile(metric, 0.25)' ];
        uy = [ uy quantile(metric, 0.75)' ];
    end

    % plot bars
    h = bar (y);
    for i = 1:length(h)
        set (h(i), 'facecolor', fade(watercolour(i), 0.5));
        set (h(i), 'edgecolor', watercolour(i));
    end

    % plot errors
    % errorbar seems to produce raster lines on SVG output, do manually
    hold on;
    for i = 1:columns(y)
        for j = 1:rows(y)
            if i == 1
                x = j - 0.2;
            else
                x = j + 0.2;
            end
            line ([x x], [ly(j,i), uy(j,i)], 'color', watercolour(i), ...
                'linewidth', 2);
            line ([x - 0.1, x + 0.1], [ly(j,i) ly(j,i)], 'color', ...
                watercolour(i), 'linewidth', 2);
            line ([x - 0.1, x + 0.1], [uy(j,i) uy(j,i)], 'color', ...
                watercolour(i), 'linewidth', 2);
        end
    end
    
    grid on;
    legend(filters, 'location', 'northwest');
    hold off;
end
