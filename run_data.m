function params = run_data(id)

    params = getparams(id);
    disp('Loading data...')
    params = load_data(params);
    params = find_active_pixels(params);
    params = make_list_of_points(params);
    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    params = select_point_positions(params,'FTOC');
    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    params = create_projection(params, 'FTOC');
    disp('Finding ectopics...')
    params = find_ectopics(params);
    params = triangulation(params,'CTOF');
    params = triangulation(params,'FTOC');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    params = find_crossings(params, 'FTOC');
    disp('Finding largest subgraph...')
    params = find_largest_subgraph(params,'CTOF');
    params = find_largest_subgraph(params,'FTOC');
    disp('Calculating stats...')
    disp('--> orientation...')
    params = find_link_angles(params,'FTOC');
    params = find_link_angles(params,'CTOF');
    disp('--> scatters...')
    params = get_subgraph_scatters(params,'FTOC');
    params = get_subgraph_scatters(params,'CTOF');
    disp('--> baseline...')
    params = find_baseline(params, 'FTOC', 5);
    params = find_baseline(params, 'CTOF', 5);
    if params.stats.num_ectopics >= 5
        disp('--> ectopics...')
        params = ectopic_order_stats(params);
    end
    
    plot_figure2(params)
    params = plot_figure3(params);
    plot_figure6(params, 'FTOC')
    figure
    plot_ectopics(params)
