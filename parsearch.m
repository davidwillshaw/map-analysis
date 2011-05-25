function mean_min_dist = parsearch(id, numpoints, ranstart)
    params = getparams(id);
    params.ranstart = ranstart;
    params.CTOF.numpoints = numpoints;
    disp('Loading data...')
    params = load_data(params);
    params = find_active_pixels(params);
    params = make_list_of_points(params);
    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    
    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    
    params = triangulation(params,'CTOF');
    
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    
    mean_min_dist = params.stats.CTOF.min_link_length_mean_coll;