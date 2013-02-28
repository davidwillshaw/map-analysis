function params = Dpostprocess(params)
% DPOSTPROCESS - Postprocessing for data - produce various plots
%   

plot_figure6(params, 'FTOC')
plot_ectopics(params)
params;
