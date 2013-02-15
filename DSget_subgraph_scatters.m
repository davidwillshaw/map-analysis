function params = DSget_subgraph_scatters(params,direction)

    if strcmp(direction,'CTOR')
        points_in_subgraph = params.CTOR.points_in_subgraph;
        points_not_in_subgraph = params.CTOR.points_not_in_subgraph;
        from_points = params.CTOR.coll_points;
        full_from_coords = params.full_coll;
        full_to_coords = params.full_ret;
        radius = params.coll_radius;
    end
    
    if strcmp(direction,'RTOC')
        points_in_subgraph = params.RTOC.points_in_subgraph;
        points_not_in_subgraph = params.RTOC.points_not_in_subgraph;
        from_points = params.RTOC.ret_points;
        full_from_coords = params.full_ret;
        full_to_coords = params.full_coll;
        radius = params.ret_radius;
    end
    
     
   [scatter_mean_in, list_of_variance_in] = find_scatter(points_in_subgraph, from_points, full_from_coords, full_to_coords, radius);
   [scatter_mean_out, list_of_variance_out] = find_scatter(points_not_in_subgraph, from_points, full_from_coords, full_to_coords, radius);
   
   if strcmp(direction,'CTOR')
       params.stats.CTOR.scatter_mean_in = scatter_mean_in;
       params.stats.CTOR.list_of_variance_in = list_of_variance_in;
       params.stats.CTOR.scatter_mean_out = scatter_mean_out;
       params.stats.CTOR.list_of_variance_out = list_of_variance_out;
   end
   
   if strcmp(direction,'RTOC')
       params.stats.RTOC.scatter_mean_in = scatter_mean_in;
       params.stats.RTOC.list_of_variance_in = list_of_variance_in;
       params.stats.RTOC.scatter_mean_out = scatter_mean_out;
       params.stats.RTOC.list_of_variance_out = list_of_variance_out;
   end
   
