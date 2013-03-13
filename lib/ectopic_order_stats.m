function params = ectopic_order_stats(params)
    
    ect = find(params.FTOC.minor_projection(:,1));
    num_points = params.FTOC.numpoints;
    non_ect = setdiff(1:num_points,ect)';
    
    %major_projection
    new_params = params;
    new_params.FTOC.coll_points = params.FTOC.major_projection;
    new_params = find_crossings(new_params, 'FTOC');
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.nodes_in_subgraph_major = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    new_params.FTOC.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'FTOC',1);
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.map_orientation_mean_major = new_params.stats.FTOC.map_orientation_mean;
    params.stats.map_orientation_std_major = new_params.stats.FTOC.map_orientation_std;
    params.stats.nodes_in_major = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    %minor_projection
    new_params = params;
    new_params.FTOC.coll_points(ect,:) = params.FTOC.minor_projection(ect,:);
    new_params = find_crossings(new_params, 'FTOC');
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.nodes_in_subgraph_minor = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    new_params.FTOC.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'FTOC',1);
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.map_orientation_mean_minor = new_params.stats.FTOC.map_orientation_mean;
    params.stats.map_orientation_std_minor = new_params.stats.FTOC.map_orientation_std;
    params.stats.nodes_in_minor = new_params.stats.FTOC.num_nodes_in_subgraph;
    
