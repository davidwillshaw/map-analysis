function params = find_subgraph_angle(params, direction)

    if strcmp(direction,'FTOC')
        list_of_neighbours = params.FTOC.list_of_neighbours;
        angles = params.FTOC.angles;
        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
    end
    
    if strcmp(direction,'CTOF')
        list_of_neighbours = params.CTOF.list_of_neighbours;
        angles = params.CTOF.angles;
        points_not_in_subgraph = params.CTOF.points_not_in_subgraph;
    end
    
    removed_points = ismember(list_of_neighbours,points_not_in_subgraph);
    links_in_subgraph = sum(removed_points,2) == 0;
    mean_subgraph_angles = mean(angles(links_in_subgraph));
    std_subgraph_angles = std(angles(links_in_subgraph));
    
    if strcmp(direction,'FTOC')
       params.stats.FTOC.mean_subgraph_angles = mean_subgraph_angles;
        params.stats.FTOC.std_subgraph_angles = std_subgraph_angles; 
    end
    
    if strcmp(direction,'CTOF')
        params.stats.CTOF.mean_subgraph_angles = mean_subgraph_angles;
        params.stats.CTOF.std_subgraph_angles = std_subgraph_angles;
    end