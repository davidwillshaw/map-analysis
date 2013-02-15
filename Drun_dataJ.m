function params = Drun_dataJ(thresh_scatter,minclustersize,noect)

%  David's version of run_data.m 
% (i)   figure 306 added which plots individual scatters  YES
%       for whole field and for largest ordered subgraph
%       to mirror Figure 6, which shows the maps
% (ii ) Dfind_three_scatter_types counts the three types  NO
%       of FTOC scatter and plots out STDs of spread in Fig 33
%       Threshold set at 2 pixels
% (iii) Remove high scatter pixels   YES

    disp(['Loading data ',num2str(id), '...'])
    params = load_data(params);
    params = find_active_pixels(params);
    params = make_list_of_points(params); 

%            HIGH SCATTER POINTS REMOVED
    params = Dremove_high_scatter(params,thresh_scatter,minclustersize);
    params = make_list_of_points(params); 

    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    params = select_point_positions(params,'FTOC');
    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    params = create_projection(params, 'FTOC');

%D  Fix for randomising FTOC along RC axis   OFF
%    NN = length(params.FTOC.coll_points(:,1));
%    params.FTOC.coll_points(:,1) = params.FTOC.coll_points(randperm(NN),1);
    disp('Finding ectopics...')
    params = Dfind_ectopics(params);
    params = triangulation(params,'CTOF');
    params = triangulation(params,'FTOC');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    params = find_crossings(params, 'FTOC');
    disp('Finding largest subgraph...')
    params = Dfind_largest_subgraph(params,'CTOF',noect);
    params = Dfind_largest_subgraph(params,'FTOC',noect);
    disp('Calculating stats...')
    disp('--> orientation...')
    params = find_link_angles(params,'FTOC');
    params = find_link_angles(params,'CTOF');
    params = find_subgraph_angle(params, 'FTOC');
    params = find_subgraph_angle(params, 'CTOF');
    disp('--> scatters...')
    params = get_subgraph_scatters(params,'FTOC');
    params = get_subgraph_scatters(params,'CTOF');
    disp('--> baseline...')
    params = find_baseline(params, 'FTOC', 5);
    params = find_baseline(params, 'CTOF', 5);
    disp('-->lower bound...')
    params = find_prob_subgraph(params,'FTOC');
    params = find_prob_subgraph(params,'CTOF');
    if params.stats.num_ectopics >= 5
        disp('--> ectopics...')
        params = ectopic_order_stats(params);
    end

%   params = Dfind_three_scatter_groups(params,2,1);    
    params = plot_figure3(params, 1);
    params = Dcalc_disps_plot306_307(params);
    
    plot_figure2(params)
    plot_figure6(params, 'FTOC')
    plot_ectopics(params)



