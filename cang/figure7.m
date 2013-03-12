function figure7()
% FIGURE7 - Plot figure 6 from Willshaw & al 2013
%   
clf

% WT
p = Drun_data(155, 1, 'UseCache', true);

% FTOC
h1 = subplot2(3, 2, 1);
h2 = subplot2(3, 2, 2);
plot_lattice(p, 'FTOC', h1, h2)

h1 = subplot2(3, 2, 3);
h2 = subplot2(3, 2, 4);
plot_lattice(p, 'FTOC', h1, h2, 'Subgraph')

h1 = subplot2(3, 2, 5);
h2 = subplot2(3, 2, 6);
plot_lattice(p, 'FTOC', h1, h2, 'Lattice', false, 'ErrorType', 'sem')
