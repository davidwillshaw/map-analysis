function params = get_subgraph_scatters(params,direction)

    if strcmp(direction,'CTOF')
        points_in_subgraph = params.CTOF.points_in_subgraph;
        points_not_in_subgraph = params.CTOF.points_not_in_subgraph;
        from_points = params.CTOF.coll_points;
        full_from_coords = params.full_coll;
        full_to_coords = params.full_field;
        radius = params.coll_radius;
    end
    
    if strcmp(direction,'FTOC')
        points_in_subgraph = params.FTOC.points_in_subgraph;
        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
        from_points = params.FTOC.field_points;
        full_from_coords = params.full_field;
        full_to_coords = params.full_coll;
        radius = params.field_radius;
    end
    
     
   [scatter_mean_in, list_of_variance_in] = find_scatter(points_in_subgraph, from_points, full_from_coords, full_to_coords, radius);
   [scatter_mean_out, list_of_variance_out] = find_scatter(points_not_in_subgraph, from_points, full_from_coords, full_to_coords, radius);
   
   if strcmp(direction,'CTOF')
       params.stats.CTOF.scatter_mean_in = scatter_mean_in;
       params.stats.CTOF.list_of_variance_in = list_of_variance_in;
       params.stats.CTOF.scatter_mean_out = scatter_mean_out;
       params.stats.CTOF.list_of_variance_out = list_of_variance_out;
   end
   
   if strcmp(direction,'FTOC')
       params.stats.FTOC.scatter_mean_in = scatter_mean_in;
       params.stats.FTOC.list_of_variance_in = list_of_variance_in;
       params.stats.FTOC.scatter_mean_out = scatter_mean_out;
       params.stats.FTOC.list_of_variance_out = list_of_variance_out;
   end
   