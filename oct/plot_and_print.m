% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_and_print ()
%
% Produce plots and print for manuscript.
% @end deftypefn
%
function plot_and_print ()
    figDir = 'figs';

    % state estimates
    set (figure(1), 'papersize', [9 8]);
    set (figure(1), 'paperposition', [0 0 9 8]);
    orient ('portrait');
    subplot(3,2,1);
    plot_metric(3);
    ax = axis();
    subplot(3,2,2);
    plot_metric(4);
    axis(ax);
    
    subplot(3,2,3);
    plot_metric(1);
    axis([ ax(1) ax(2) 0 1 ]);
    subplot(3,2,4);
    plot_metric(2);
    axis([ ax(1) ax(2) 0 1 ]);
    
    subplot(3,2,5);
    plot_metric(5);
    subplot(3,2,6);
    plot_metric(6);
    
    saveas (figure(1), sprintf('%s/metrics.svg', figDir));
    saveas (figure(1), sprintf('%s/metrics.pdf', figDir));

    clf;
    set (figure(1), 'papersize', [3.5 8]);
    set (figure(1), 'paperposition', [0 0 3.5 8]);
    orient ('landscape');
    plot_weight;
    saveas (figure(1), sprintf('%s/weights.svg', figDir));
    saveas (figure(1), sprintf('%s/weights.pdf', figDir));

    clf;
    set (figure(1), 'papersize', [3.5 8]);
    set (figure(1), 'paperposition', [0 0 3.5 8]);
    orient ('landscape');
    plot_paths;
    saveas (figure(1), sprintf('%s/paths.svg', figDir));
    saveas (figure(1), sprintf('%s/paths.pdf', figDir));
end
