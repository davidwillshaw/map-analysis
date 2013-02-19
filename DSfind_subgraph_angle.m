function params = DSfind_subgraph_angle(params, direction)

    if strcmp(direction,'RTOC')
        list_of_neighbours = params.RTOC.list_of_neighbours
        points_in_subgraph = params.RTOC.points_in_subgraph
        from_coords = params.RTOC.ret_points;
        to_coords = params.RTOC.coll_points;
        angles = params.RTOC.angles;

        points_not_in_subgraph = params.RTOC.points_not_in_subgraph;
        triangles = params.RTOC.triangles;
        takeout = params.RTOC.takeout;
    end
    
    if strcmp(direction,'CTOR')
        points_in_subgraph = params.CTOR.points_in_subgraph;
        list_of_neighbours = params.CTOR.list_of_neighbours;
        from_coords = params.CTOR.ret_points;
        to_coords = params.CTOR.coll_points;
        angles = params.CTOR.angles;
        points_not_in_subgraph = params.CTOR.points_not_in_subgraph;
        triangles = params.CTOR.triangles;
        takeout = params.CTOR.takeout;
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
    
    if strcmp(direction,'RTOC')
       params.RTOC.subgraph_angles=angles;
       params.stats.RTOC.mean_subgraph_angles = mean_subgraph_angles;
       params.stats.RTOC.std_subgraph_angles = std_subgraph_angles; 
    end
    
    if strcmp(direction,'CTOR')
       params.CTOR.subgraph_angles=angles;
       params.stats.CTOR.mean_subgraph_angles = mean_subgraph_angles;
       params.stats.CTOR.std_subgraph_angles = std_subgraph_angles;
    end
