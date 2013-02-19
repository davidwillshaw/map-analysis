function params = DSrun_data(id,N,radius,ectopicnodes);

% David's version for running simulation data (DS...)


%  David's version of run_data.m 
% (i)   figure 306 added which plots individual scatters  YES
%       for whole retina and for largest ordered subgraph
%       to mirror Figure 6, which shows the maps
% (ii ) Dfind_three_scatter_types counts the three types  NO
%       of RTOC scatter and plots out STDs of spread in Fig 33
%       Threshold set at 2 pixels
% (iii) Remove high scatter pixels   YES

    params = DSgetparams(id,N,radius);
    disp(['Loading data ',num2str(id), '...'])
    params = DSload_data(params);

    disp('Selecting point positions...')
    params = DSselect_point_positions(params,'CTOR');
    params = DSselect_point_positions(params,'RTOC');

    disp('Creating projection...')
    params = DScreate_projection(params, 'CTOR');
    params = DScreate_projection(params, 'RTOC');

%D  Fix for randomising RTOC along RC axis   OFF
%    NN = length(params.RTOC.coll_points(:,1));
%    params.RTOC.coll_points(:,1) = params.RTOC.coll_points(randperm(NN),1);
    disp('Finding ectopics...')
    params = DSfind_ectopics(params);
    params = DStriangulation(params,'CTOR');
    params = DStriangulation(params,'RTOC');
    disp('Finding crossings...')
    params = DSfind_crossings(params, 'CTOR');
    params = DSfind_crossings(params, 'RTOC');

    disp('Finding largest subgraph...')
    params = DSfind_largest_subgraph(params,'CTOR',ectopicnodes);
    params = DSfind_largest_subgraph(params,'RTOC',ectopicnodes);

    disp('Calculating stats...')
    disp('--> orientation...')
    params = DSfind_link_angles(params,'RTOC');
    params = DSfind_link_angles(params,'CTOR');

    params = DSfind_subgraph_angle(params, 'RTOC');
    params = DSfind_subgraph_angle(params, 'CTOR');
    disp('--> scatters...')

    params = DSget_subgraph_scatters(params,'RTOC');
    params = DSget_subgraph_scatters(params,'CTOR');
%    disp('--> baseline...')
%    params = find_baseline(params, 'RTOC', 5);
%    params = find_baseline(params, 'CTOR', 5);
%    disp('-->lower bound...')
%    params = find_prob_subgraph(params,'RTOC');
%    params = find_prob_subgraph(params,'CTOR');
     params.stats.num_ectopics =0;
    if params.stats.num_ectopics >= 5
        disp('--> ectopics...')
        params = ectopic_order_stats(params);
    end

%   params = Dfind_three_scatter_groups(params,2,1);    
    params = DSplot_figure3(params);

%    params = Dcalc_disps_plot306_307(params);
    
     DSplot_figure2(params)
     DSplot_figure6(params, 'RTOC')
%   plot_ectopics(params)



