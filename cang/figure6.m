function figure6(p)
% FIGURE6 - Plot figure 6 from Willshaw & al 2013
%
figure(6)   
clf

% WT

%p = Drun_data(10, 1, 'UseCache', true);

% FTOC
h1 = subplot2(2, 3, 1);
h2 = subplot2(2, 3, 2);
plot_lattice(p, 'FTOC', h1, h2)

h3 = subplot2(2, 3, 3);
plot_angles(p, 'FTOC', h3)

% CTOF
h1 = subplot2(2, 3, 4);
h2 = subplot2(2, 3, 5);
plot_lattice(p, 'CTOF', h1, h2)

h3 = subplot2(2, 3, 6);
plot_angles(p, 'CTOF', h3)

