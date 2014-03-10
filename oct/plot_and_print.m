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
    FIG_DIR = 'figs';
    sz = [ 11 4 ];
    set (figure(1), 'papersize', sz);
    set (figure(1), 'paperposition', [0 0 sz]);

    subplot(1,3,1);
    plot_metric(4);
    title('-\sigma/t');
    xlabel('Bootstrap');
    ylabel('Bridge');
    subplot(1,3,2);
    plot_metric(1);
    title('ESS/t');
    xlabel('Bootstrap');
    subplot(1,3,3);
    plot_metric(2);
    title('CAR/t');
    xlabel('Bootstrap');
    file = sprintf('%s/metrics.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));

    clf;
    plot_weight;
    file = sprintf('%s/weights.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));

    %clf;
    %set (figure(1), 'papersize', [3.5 8]);
    %set (figure(1), 'paperposition', [0 0 3.5 8]);
    %orient ('landscape');
    %plot_paths;
    %saveas (figure(1), sprintf('%s/paths.svg', figDir));
    %saveas (figure(1), sprintf('%s/paths.pdf', figDir));
end
