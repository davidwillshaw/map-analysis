function params = find_largest_subgraph(params,direction)
%takes in a set of intersections and removes nodes until there are no
%intersections left. Nodes are ranked by the number of crossings they
%remove divided by the number of links that would be removed to preserve a
%fully connected graph. It returns two lists, one with the nodes in the
%largest connected subgraph and one with the nodes that have been removed.
%
%Needs: sets_of_intersections, list_of_neighbours,takeout,numpoints
%Returns: points_in_subgraph, points_not_in_subgraph

    if strcmp(direction, 'CTOF')
        sets_of_intersections = params.CTOF.sets_of_intersections;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        takeout = params.CTOF.takeout;
        num_points = params.CTOF.numpoints;
    end

    if strcmp(direction, 'FTOC')
        sets_of_intersections = params.FTOC.sets_of_intersections;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        takeout = params.FTOC.takeout;
        num_points = params.FTOC.numpoints;
    end
    
    candidates = setdiff((1:num_points),takeout);
    active_sets_of_intersections = remove_links_including_nodes(sets_of_intersections,takeout);
    points_not_in_subgraph = takeout;
    active_list_of_neighbours = remove_links_including_nodes(list_of_neighbours,takeout);
    
    while ~isempty(active_sets_of_intersections)
        intersection_points = unique(active_sets_of_intersections(:));
        count = hist(active_sets_of_intersections(:),intersection_points);
        [~,sorted_points] = sort(count,'descend');
        intersection_points = intersection_points(sorted_points);
        points_to_remove = find_worst_point(intersection_points,...
            active_list_of_neighbours,active_sets_of_intersections);
        points_not_in_subgraph = [points_not_in_subgraph; points_to_remove'];
        active_sets_of_intersections = remove_links_including_nodes(active_sets_of_intersections,points_to_remove);
        active_list_of_neighbours = remove_links_including_nodes(active_list_of_neighbours,points_to_remove);
    end
    
    points_in_subgraph = setdiff(candidates,points_not_in_subgraph);
    
    if strcmp(direction, 'CTOF')
        params.CTOF.points_in_subgraph = points_in_subgraph;
        params.CTOF.points_not_in_subgraph = points_not_in_subgraph;
        params.stats.CTOF.num_nodes_in_subgraph = length(points_in_subgraph);
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.points_in_subgraph = points_in_subgraph;
        params.FTOC.points_not_in_subgraph = points_not_in_subgraph;
        params.stats.FTOC.num_nodes_in_subgraph = length(points_in_subgraph);
    end
    
    