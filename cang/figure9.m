function figure9()
% FIGURE9 - Plot figure 9 from Willshaw & al 2013
%   
clf

% Het TKO 3+- 161
p = Drun_data(84, 1, 'UseCache', true);
do_plot(p, 1)


% Het TKO 3+- 82
p = Drun_data(94, 1, 'UseCache', true);
do_plot(p, 3)


% Het TKO 3+- 162
p = Drun_data(162, 1, 'UseCache', true);
do_plot(p, 7)

% ephrin het TKO 5+/-  84 
p = Drun_data(161, 1, 'UseCache', true);
do_plot(p, 9)

% ephrin het TKO 5+/- 94 
p = Drun_data(82, 1, 'UseCache', true);
do_plot(p, 11)

% Homo triple knockout 004 
p = Drun_data(56, 1, 'UseCache', true);
do_plot(p, 13)

% Homo triple knockout 054 
p = Drun_data(54, 1, 'UseCache', true);
do_plot(p, 15)

% Homo triple knockout 055 
p = Drun_data(58, 1, 'UseCache', true);
do_plot(p, 17)

% 56 Homo triple knockout 056 
p = Drun_data(55, 1, 'UseCache', true);
do_plot(p, 19)

% 58 Homo triple knockout 058 
p = Drun_data(4, 1, 'UseCache', true);
do_plot(p, 21)

end

function do_plot(p, pane)

nrow = 4;
ncol = 6;

h1 = subplot2(nrow, ncol, pane);
h2 = subplot2(nrow, ncol, pane + 1);
plot_lattice(p, 'FTOC', h1, h2, 'Subgraph', true)

end