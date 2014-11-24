function params = find_largest_subgraph(params,direction,ectopicnodes)
% FIND_LARGEST_SUBGRAPH - takes in a set of intersections and removes nodes until there are no
% intersections left.
%D modified - takeout  OFF

%takes in a set of intersections and removes nodes until there are no
%intersections left. Nodes are ranked by the number of crossings they
%remove divided by the number of links that would be removed to preserve a
%fully connected graph. It returns two lists, one with the nodes in the
%largest connected subgraph and one with the nodes that have been removed.
%
% ectopicnodes set to 1 implies ectopics included
%Needs: sets_of_intersections, list_of_neighbours,takeout,numpoints,neighbours, candidates
%Returns: points_in_subgraph, points_not_in_subgraph

    if (~exist('ectopicnodes'))
        ectopicnodes = true;
    end
    
    if strcmp(direction, 'CTOF')
        sets_of_intersections = params.CTOF.sets_of_intersections;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        takeout = params.CTOF.takeout;
        num_points = params.CTOF.numpoints;
        candidates=params.CTOF.candidates;
    end

    if strcmp(direction, 'FTOC')
        sets_of_intersections = params.FTOC.sets_of_intersections;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        if ectopicnodes==0
            takeout = union(params.FTOC.takeout,params.FTOC.stats.ectopics);
        else
            takeout = params.FTOC.takeout;
        end

        num_points = params.FTOC.numpoints;
        candidates=params.FTOC.candidates;;
    end

%	candidates = setdiff((1:num_points),takeout);
	candidates = setdiff(candidates,takeout);
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
        PP = points_in_subgraph;
;       sum1=sum(sum(params.CTOF.neighbours(:,:)));
        sum2=sum(sum(params.CTOF.neighbours(PP,PP)));
        params.CTOF.percent_edges_in_subgraph=100*sum2/sum1;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.points_in_subgraph = points_in_subgraph;
        params.FTOC.points_not_in_subgraph = points_not_in_subgraph;
        params.stats.FTOC.num_nodes_in_subgraph = length(points_in_subgraph);
        PP = points_in_subgraph;
;       sum1=sum(sum(params.FTOC.neighbours(:,:)));
        sum2=sum(sum(params.FTOC.neighbours(PP,PP)));
        params.FTOC.percent_edges_in_subgraph=100*sum2/sum1;
    end
    
    
