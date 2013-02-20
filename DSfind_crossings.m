function params = DSfind_crossings(params, direction)
   
    if strcmp(direction,'CTOF')
        projected_points = params.CTOF.field_points;
        neighbours = params.CTOF.neighbours;
    end
    
    if strcmp(direction,'FTOC')
        projected_points = params.FTOC.coll_points;
        neighbours = params.FTOC.neighbours;
    end

    sets_of_intersections = [];
    unique_neighbours = triu(neighbours,1);
    [neighbour1, neighbour2] = find(unique_neighbours);
    list_of_neighbours = [neighbour1, neighbour2];
    num_edges = length(list_of_neighbours);
    for primary_edge = 1:num_edges
        edge1 = list_of_neighbours(primary_edge,:);
        list_of_neigh_to_check = list_of_neighbours(primary_edge:num_edges,:);
        [rows_to_delete, ~] = find(list_of_neigh_to_check==edge1(1)|list_of_neigh_to_check==edge1(2));
        rows_to_delete = unique(rows_to_delete);
        list_of_neigh_to_check(rows_to_delete,:) = [];
        for edge = 1:size(list_of_neigh_to_check,1)
            edge2 = list_of_neigh_to_check(edge,:);
            if doescross(edge1,edge2,projected_points);
                sets_of_intersections = [sets_of_intersections; edge1, edge2];
            end
        end
    end
    
    if strcmp(direction,'CTOF')
        params.CTOF.list_of_neighbours = list_of_neighbours;
        params.CTOF.sets_of_intersections = sets_of_intersections;
        %mean link lengths coll
        coords = params.CTOF.coll_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.CTOF.link_length_mean_coll = link_length_mean;
        params.stats.CTOF.link_length_std_coll = link_length_std;
        params.stats.CTOF.min_link_length_mean_coll = min_link_length_mean;
        params.stats.CTOF.min_link_length_std_coll = min_link_length_std;
        %mean link lengths ret
        coords = params.CTOF.field_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
         [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.CTOF.link_length_mean_field = link_length_mean;
        params.stats.CTOF.link_length_std_field = link_length_std;
        params.stats.CTOF.min_link_length_mean_field = min_link_length_mean;
        params.stats.CTOF.min_link_length_std_field = min_link_length_std;
        params.stats.CTOF.num_crossings = size(sets_of_intersections,1);
        params.stats.CTOF.num_nodes_crossing = length(unique(sets_of_intersections));
    end
    
    if strcmp(direction,'FTOC')
        params.FTOC.list_of_neighbours = list_of_neighbours;
        params.FTOC.sets_of_intersections = sets_of_intersections;
        %mean link lengths coll
        coords = params.FTOC.coll_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.FTOC.link_length_mean_coll = link_length_mean;
        params.stats.FTOC.link_length_std_coll = link_length_std;
        params.stats.FTOC.min_link_length_mean_coll = min_link_length_mean;
        params.stats.FTOC.min_link_length_std_coll = min_link_length_std;
        %mean link lengths ret
        coords = params.FTOC.field_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.FTOC.link_length_mean_field = link_length_mean;
        params.stats.FTOC.link_length_std_field = link_length_std;
        params.stats.FTOC.min_link_length_mean_field = min_link_length_mean;
        params.stats.FTOC.min_link_length_std_field = min_link_length_std;
        params.stats.FTOC.num_crossings = size(sets_of_intersections,1);
        params.stats.FTOC.num_nodes_crossing = length(unique(sets_of_intersections));
    end
    
    
                
