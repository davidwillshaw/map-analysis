function params = DSfind_crossings(params, direction)
   
    if strcmp(direction,'CTOR')
        projected_points = params.CTOR.ret_points;
        neighbours = params.CTOR.neighbours;
    end
    
    if strcmp(direction,'RTOC')
        projected_points = params.RTOC.coll_points;
        neighbours = params.RTOC.neighbours;
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
    
    if strcmp(direction,'CTOR')
        params.CTOR.list_of_neighbours = list_of_neighbours;
        params.CTOR.sets_of_intersections = sets_of_intersections;
        %mean link lengths coll
        coords = params.CTOR.coll_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.CTOR.link_length_mean_coll = link_length_mean;
        params.stats.CTOR.link_length_std_coll = link_length_std;
        params.stats.CTOR.min_link_length_mean_coll = min_link_length_mean;
        params.stats.CTOR.min_link_length_std_coll = min_link_length_std;
        %mean link lengths ret
        coords = params.CTOR.ret_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
         [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.CTOR.link_length_mean_ret = link_length_mean;
        params.stats.CTOR.link_length_std_ret = link_length_std;
        params.stats.CTOR.min_link_length_mean_ret = min_link_length_mean;
        params.stats.CTOR.min_link_length_std_ret = min_link_length_std;
        params.stats.CTOR.num_crossings = size(sets_of_intersections,1);
        params.stats.CTOR.num_nodes_crossing = length(unique(sets_of_intersections));
    end
    
    if strcmp(direction,'RTOC')
        params.RTOC.list_of_neighbours = list_of_neighbours;
        params.RTOC.sets_of_intersections = sets_of_intersections;
        %mean link lengths coll
        coords = params.RTOC.coll_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.RTOC.link_length_mean_coll = link_length_mean;
        params.stats.RTOC.link_length_std_coll = link_length_std;
        params.stats.RTOC.min_link_length_mean_coll = min_link_length_mean;
        params.stats.RTOC.min_link_length_std_coll = min_link_length_std;
        %mean link lengths ret
        coords = params.RTOC.ret_points;
        [link_length_mean, link_length_std] = find_mean_link_length(list_of_neighbours,coords);
        [min_link_length_mean, min_link_length_std] = find_min_link_length_mean(neighbours,coords);
        params.stats.RTOC.link_length_mean_ret = link_length_mean;
        params.stats.RTOC.link_length_std_ret = link_length_std;
        params.stats.RTOC.min_link_length_mean_ret = min_link_length_mean;
        params.stats.RTOC.min_link_length_std_ret = min_link_length_std;
        params.stats.RTOC.num_crossings = size(sets_of_intersections,1);
        params.stats.RTOC.num_nodes_crossing = length(unique(sets_of_intersections));
    end
    
    
                
