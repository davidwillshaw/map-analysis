function figure10()
% FIGURE10 - Plot figure 8 from Willshaw & al 2013
%   
clf

% WT
p = Drun_data(56, 1, 'UseCache', true);

% FTOC
h1 = subplot2(4, 2, 1);
h2 = subplot2(4, 2, 2);
plot_lattice(p, 'FTOC', h1, h2)

h1 = subplot2(4, 2, 3);
h2 = subplot2(4, 2, 4);
plot_lattice(p, 'FTOC', h1, h2, 'Subgraph')

h1 = subplot2(4, 2, 5);
h2 = subplot2(4, 2, 6);
plot_lattice(p, 'FTOC', h1, h2, 'Subgraph', true, 'EctOptions', 4)

h1 = subplot2(4, 2, 7);
h2 = subplot2(4, 2, 8);
plot_lattice(p, 'FTOC', h1, h2, 'Lattice', false, 'ErrorType', 'sem')
