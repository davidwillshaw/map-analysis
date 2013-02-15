function params = DSfind_link_angles(params,direction)

    if strcmp(direction, 'RTOC')
        list_of_neighbours = params.RTOC.list_of_neighbours;
        from_coords = params.RTOC.ret_points;
        to_coords = params.RTOC.coll_points;
        triangles = params.RTOC.triangles;
        takeout = params.RTOC.takeout;
    end
    
    if strcmp(direction, 'CTOR')
        list_of_neighbours = params.CTOR.list_of_neighbours;
        from_coords = params.CTOR.coll_points;
        to_coords = params.CTOR.ret_points;
        triangles = params.CTOR.triangles;
        takeout = params.CTOR.takeout;
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
    
    if strcmp(direction, 'RTOC')
        params.RTOC.flipped_links = flipped_links;
        params.RTOC.norm_links = norm_links;
        params.RTOC.angles = angles;
        params.RTOC.orientations = orientations;
        params.stats.RTOC.map_orientation_mean = circ_mean(angles);
        params.stats.RTOC.map_orientation_std = circ_std(angles);
    end
    
    if strcmp(direction, 'CTOR')
        params.CTOR.flipped_links = flipped_links;
        params.CTOR.norm_links = norm_links;
        params.CTOR.angles = angles;
        params.CTOR.orientations = orientations;
        params.stats.CTOR.map_orientation_mean = circ_mean(angles);
        params.stats.CTOR.map_orientation_std = circ_std(angles);
    end
            
        
        
        
        
        
    
    
