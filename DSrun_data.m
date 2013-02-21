function params = DSrun_data(id,N,radius,ectopicnodes);

% David's version for running simulation data (DS...)


%  David's version of run_data.m 
% (i)   figure 306 added which plots individual scatters  YES
%       for whole retina and for largest ordered subgraph
%       to mirror Figure 6, which shows the maps
% (ii ) Dfind_three_scatter_types counts the three types  NO
%       of FTOC scatter and plots out STDs of spread in Fig 33
%       Threshold set at 2 pixels
% (iii) Remove high scatter pixels   YES

    params = DSgetparams(id,N,radius);
    disp(['Loading data ',num2str(id), '...'])
    params = DSload_data(params);

    disp('Selecting point positions...')
    params = DSselect_point_positions(params,'CTOF');
    params = DSselect_point_positions(params,'FTOC');

    disp('Creating projection...')
    params = DScreate_projection(params, 'CTOF');
    params = DScreate_projection(params, 'FTOC');

%D  Fix for randomising FTOC along RC axis   OFF
%    NN = length(params.FTOC.coll_points(:,1));
%    params.FTOC.coll_points(:,1) = params.FTOC.coll_points(randperm(NN),1);
    disp('Finding ectopics...')
    params = DSfind_ectopics(params);
    params = triangulation(params,'CTOF');
    params = triangulation(params,'FTOC');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    params = find_crossings(params, 'FTOC');

    disp('Finding largest subgraph...')
    params = DSfind_largest_subgraph(params,'CTOF',ectopicnodes);
    params = DSfind_largest_subgraph(params,'FTOC',ectopicnodes);

    disp('Calculating stats...')
    disp('--> orientation...')
    params = DSfind_link_angles(params,'FTOC');
    params = DSfind_link_angles(params,'CTOF');

    params = DSfind_subgraph_angle(params, 'FTOC');
    params = DSfind_subgraph_angle(params, 'CTOF');
    disp('--> scatters...')

    params = DSget_subgraph_scatters(params,'FTOC');
    params = DSget_subgraph_scatters(params,'CTOF');
%    disp('--> baseline...')
%    params = find_baseline(params, 'FTOC', 5);
%    params = find_baseline(params, 'CTOF', 5);
%    disp('-->lower bound...')
%    params = find_prob_subgraph(params,'FTOC');
%    params = find_prob_subgraph(params,'CTOF');
     params.stats.num_ectopics =0;
    if params.stats.num_ectopics >= 5
        disp('--> ectopics...')
        params = ectopic_order_stats(params);
    end

%   params = Dfind_three_scatter_groups(params,2,1);    
    params = DSplot_figure3(params);

%    params = Dcalc_disps_plot306_307(params);
    
     DSplot_figure2(params)
     DSplot_figure6(params, 'FTOC')
%   plot_ectopics(params)



