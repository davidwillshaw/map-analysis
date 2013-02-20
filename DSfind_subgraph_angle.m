function params = DSfind_subgraph_angle(params, direction)

    if strcmp(direction,'FTOC')
        list_of_neighbours = params.FTOC.list_of_neighbours
        points_in_subgraph = params.FTOC.points_in_subgraph
        from_coords = params.FTOC.field_points;
        to_coords = params.FTOC.coll_points;
        angles = params.FTOC.angles;

        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
        triangles = params.FTOC.triangles;
        takeout = params.FTOC.takeout;
    end
    
    if strcmp(direction,'CTOF')
        points_in_subgraph = params.CTOF.points_in_subgraph;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        from_coords = params.CTOF.field_points;
        to_coords = params.CTOF.coll_points;
        angles = params.CTOF.angles;
        points_not_in_subgraph = params.CTOF.points_not_in_subgraph;
        triangles = params.CTOF.triangles;
        takeout = params.CTOF.takeout;
    end
    
    removed_points = ismember(list_of_neighbours,points_not_in_subgraph);
    links_in_subgraph = sum(removed_points,2) == 0;

    takeout = union(points_not_in_subgraph,takeout);
    
    list_of_neighbours = remove_links_including_nodes(list_of_neighbours, takeout);
    triangles = remove_links_including_nodes(triangles, takeout);
    
    num_links = size(list_of_neighbours,1);
    list_of_neighbours
    length(list_of_neighbours)
    length(from_coords)
    angles = find_rel_angles(list_of_neighbours,from_coords,to_coords)
   
    mean_subgraph_angles = mean(angles)
    std_subgraph_angles = std(angles);
    
    if strcmp(direction,'FTOC')
       params.FTOC.subgraph_angles=angles;
       params.stats.FTOC.mean_subgraph_angles = mean_subgraph_angles;
       params.stats.FTOC.std_subgraph_angles = std_subgraph_angles; 
    end
    
    if strcmp(direction,'CTOF')
       params.CTOF.subgraph_angles=angles;
       params.stats.CTOF.mean_subgraph_angles = mean_subgraph_angles;
       params.stats.CTOF.std_subgraph_angles = std_subgraph_angles;
    end
