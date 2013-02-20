function params = DSfind_link_angles(params,direction)

    if strcmp(direction, 'FTOC')
        list_of_neighbours = params.FTOC.list_of_neighbours;
        from_coords = params.FTOC.field_points;
        to_coords = params.FTOC.coll_points;
        triangles = params.FTOC.triangles;
        takeout = params.FTOC.takeout;
    end
    
    if strcmp(direction, 'CTOF')
        list_of_neighbours = params.CTOF.list_of_neighbours;
        from_coords = params.CTOF.coll_points;
        to_coords = params.CTOF.field_points;
        triangles = params.CTOF.triangles;
        takeout = params.CTOF.takeout;
    end
    
    list_of_neighbours = remove_links_including_nodes(list_of_neighbours, takeout);
    triangles = remove_links_including_nodes(triangles, takeout);
    
    num_links = size(list_of_neighbours,1);
    angles = find_rel_angles(list_of_neighbours,from_coords,to_coords);
    orientations = find_flipped_triangles(triangles,from_coords,to_coords);
    norm_links = zeros(num_links,1);
    flipped_links = zeros(num_links,1);
    
    for link = 1:num_links
        active_link = list_of_neighbours(link,:);
        nodes_in_triangles = ismember(triangles,active_link);
        link_in_triangles = sum(nodes_in_triangles,2) >= 2;
        link_member_of = orientations(link_in_triangles);
        num_el = length(link_member_of);
        if sum(link_member_of) < num_el
            flipped_links(link) = 1;
        end
        
        if sum(link_member_of) > 0
            norm_links(link) = 1;
        end
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.flipped_links = flipped_links;
        params.FTOC.norm_links = norm_links;
        params.FTOC.angles = angles;
        params.FTOC.orientations = orientations;
        params.stats.FTOC.map_orientation_mean = circ_mean(angles);
        params.stats.FTOC.map_orientation_std = circ_std(angles);
    end
    
    if strcmp(direction, 'CTOF')
        params.CTOF.flipped_links = flipped_links;
        params.CTOF.norm_links = norm_links;
        params.CTOF.angles = angles;
        params.CTOF.orientations = orientations;
        params.stats.CTOF.map_orientation_mean = circ_mean(angles);
        params.stats.CTOF.map_orientation_std = circ_std(angles);
    end
            
        
        
        
        
        
    
    
