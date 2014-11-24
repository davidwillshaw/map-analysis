function params = ectopic_order_stats(params,direction)

if direction=='FTOC'   
    ect = find(params.FTOC.minor_projection(:,1));
    num_points = params.FTOC.numpoints;
    non_ect = setdiff(1:num_points,ect)';
    
    %major_projection
    new_params = params;
    new_params.FTOC.coll_points = params.FTOC.major_projection;
    new_params = find_crossings(new_params, 'FTOC');
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.FTOC.nodes_in_subgraph_major = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    new_params.FTOC.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'FTOC',1);
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.FTOC.map_orientation_mean_major = new_params.stats.FTOC.map_orientation_mean;
    params.stats.FTOC.map_orientation_std_major = new_params.stats.FTOC.map_orientation_std;
    params.stats.FTOC.nodes_in_major = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    %minor_projection
    new_params = params;
    new_params.FTOC.coll_points(ect,:) = params.FTOC.minor_projection(ect,:);
    new_params = find_crossings(new_params, 'FTOC');
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.FTOC.nodes_in_subgraph_minor = new_params.stats.FTOC.num_nodes_in_subgraph;
    
    new_params.FTOC.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'FTOC',1);
    new_params = find_largest_subgraph(new_params,'FTOC');
    params.stats.FTOC.map_orientation_mean_minor = new_params.stats.FTOC.map_orientation_mean;
    params.stats.FTOC.map_orientation_std_minor = new_params.stats.FTOC.map_orientation_std;
    params.stats.FTOC.nodes_in_minor = new_params.stats.FTOC.num_nodes_in_subgraph;
    
end

if direction=='CTOF'   
    ect = find(params.CTOF.minor_projection(:,1));
    num_points = params.CTOF.numpoints;
    non_ect = setdiff(1:num_points,ect)';
    
    %major_projection
    new_params = params;
    new_params.CTOF.field_points = params.CTOF.major_projection;
    new_params = find_crossings(new_params, 'CTOF');
    new_params = find_largest_subgraph(new_params,'CTOF');
    params.stats.CTOF.nodes_in_subgraph_major = new_params.stats.CTOF.num_nodes_in_subgraph;
    
    new_params.CTOF.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'CTOF',1);
    new_params = find_largest_subgraph(new_params,'CTOF');
    params.stats.CTOF.map_orientation_mean_major = new_params.stats.CTOF.map_orientation_mean;
    params.stats.CTOF.map_orientation_std_major = new_params.stats.CTOF.map_orientation_std;
    params.stats.CTOF.nodes_in_major = new_params.stats.CTOF.num_nodes_in_subgraph;
    
    %minor_projection
    new_params = params;
    new_params.CTOF.field_points(ect,:) = params.CTOF.minor_projection(ect,:);
    new_params = find_crossings(new_params, 'CTOF');
    new_params = find_largest_subgraph(new_params,'CTOF');
    params.stats.CTOF.nodes_in_subgraph_minor = new_params.stats.CTOF.num_nodes_in_subgraph;
    
    new_params.CTOF.takeout = non_ect;
    
    new_params = find_link_angles(new_params,'CTOF',1);
    new_params = find_largest_subgraph(new_params,'CTOF');
    params.stats.CTOF.map_orientation_mean_minor = new_params.stats.CTOF.map_orientation_mean;
    params.stats.CTOF.map_orientation_std_minor = new_params.stats.CTOF.map_orientation_std;
    params.stats.CTOF.nodes_in_minor = new_params.stats.CTOF.num_nodes_in_subgraph;
    
end
