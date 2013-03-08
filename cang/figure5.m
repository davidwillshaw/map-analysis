function figure5()
% FIGURE5 - Plot figure 5 from Willshaw & al 2013
%   
clf

% WT
p = Drun_data(10, 1, 'UseCache', true);

% FTOC
h1 = subplot2(2, 2, 1);
h2 = subplot2(2, 2, 2);
plot_lattice(p, 'FTOC', h1, h2, 'ErrorType', 'sd', 'Lattice', false)

% CTOF
h1 = subplot2(2, 2, 3);
h2 = subplot2(2, 2, 4);
plot_lattice(p, 'CTOF', h1, h2, 'ErrorType', 'sd', 'Lattice', false)

