function params = find_baseline(params, direction, replications)

    new_params = params;
    
    if strcmp(direction, 'CTOF')
        num_points = params.CTOF.numpoints; 
    end

    if strcmp(direction, 'FTOC')
        num_points = params.FTOC.numpoints;    
    end

    num_nodes_crossing = zeros(replications,1);
    num_crosses = zeros(replications,1);
    num_nodes_in_submap = zeros(replications,1);
    link_angle_mean = zeros(replications,1);
    
    for rep = 1:replications
        new_order = randperm(num_points);
        if strcmp(direction,'FTOC')
            new_params.FTOC.coll_points(:,2) = params.FTOC.coll_points(new_order,2);
            new_params = find_crossings(new_params, 'FTOC');
            new_params = find_largest_subgraph(new_params,'FTOC');
            new_params = find_link_angles(new_params,'FTOC');
            num_nodes_crossing(rep) = new_params.stats.FTOC.num_crossings;
            num_crosses(rep) = new_params.stats.FTOC.num_nodes_crossing;
            num_nodes_in_submap(rep) = new_params.stats.FTOC.num_nodes_in_subgraph;
            link_angle_mean(rep) = new_params.stats.FTOC.map_orientation_mean; 
        end
        
        if strcmp(direction,'CTOF')
            new_params.CTOF.coll_points(:,2) = params.CTOF.field_points(new_order,2);
            new_params = find_crossings(new_params, 'CTOF');
            new_params = find_largest_subgraph(new_params,'CTOF');
            new_params = find_link_angles(new_params,'CTOF');
            num_nodes_crossing(rep) = new_params.stats.CTOF.num_crossings;
            num_crosses(rep) = new_params.stats.CTOF.num_nodes_crossing;
            num_nodes_in_submap(rep) = new_params.stats.CTOF.num_nodes_in_subgraph;
            link_angle_mean(rep) = new_params.stats.CTOF.map_orientation_mean;
        end
    end
            
    
    if strcmp(direction,'CTOF')
        params.stats.CTOF.baseline.num_nodes_crossing = num_nodes_crossing;
        params.stats.CTOF.baseline.num_crosses = num_crosses;
        params.stats.CTOF.baseline.num_nodes_in_submap = num_nodes_in_submap;
        params.stats.CTOF.baseline.link_angle_mean = link_angle_mean;
    end
    
    if strcmp(direction,'FTOC')
        params.stats.FTOC.baseline.num_nodes_crossing = num_nodes_crossing;
        params.stats.FTOC.baseline.num_crosses = num_crosses;
        params.stats.FTOC.baseline.num_nodes_in_submap = num_nodes_in_submap;
        params.stats.FTOC.baseline.link_angle_mean = link_angle_mean;
    end
    
    