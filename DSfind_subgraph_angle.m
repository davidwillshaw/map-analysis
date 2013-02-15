function params = DSfind_subgraph_angle(params, direction)

    if strcmp(direction,'RTOC')
        list_of_neighbours = params.RTOC.list_of_neighbours;
        angles = params.RTOC.angles;
        points_not_in_subgraph = params.RTOC.points_not_in_subgraph;
    end
    
    if strcmp(direction,'CTOR')
        list_of_neighbours = params.CTOR.list_of_neighbours;
        angles = params.CTOR.angles;
        points_not_in_subgraph = params.CTOR.points_not_in_subgraph;
    end
    
    removed_points = ismember(list_of_neighbours,points_not_in_subgraph);
    links_in_subgraph = sum(removed_points,2) == 0;
    mean_subgraph_angles = mean(angles(links_in_subgraph));
    std_subgraph_angles = std(angles(links_in_subgraph));
    
    if strcmp(direction,'RTOC')
       params.stats.RTOC.mean_subgraph_angles = mean_subgraph_angles;
        params.stats.RTOC.std_subgraph_angles = std_subgraph_angles; 
    end
    
    if strcmp(direction,'CTOR')
        params.stats.CTOR.mean_subgraph_angles = mean_subgraph_angles;
        params.stats.CTOR.std_subgraph_angles = std_subgraph_angles;
    end
