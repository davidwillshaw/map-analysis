function params = create_projection(params, direction)
% Takes in a list of all active points, a lits of point centres and a
% direction of mapping and returns the mean projection of each point.

    if strcmp(direction, 'FTOC')
        set_points = params.FTOC.field_points;
        mapping_from = params.full_field;
    end
    
    if strcmp(direction, 'CTOF')
        set_points = params.CTOF.coll_points;
        mapping_from = params.full_coll;
        radius = params.coll_radius;
        num_points = params.numpoints;
    end
    
    mapping_to = zeros(num_points,2);
    
    for point = 1:num_points
        selected_point = set_points(point,:);
        dists = sqrt((mapping_from(:,1) - selected_point(1)).^2 + ...
            (mapping_from(:,2) - selected_point(2)).^2);
        [points_in_radius,~] = find(dists<radius);
        mean_projection = mean(mapping_from(points_in_radius,:));
        mapping_to(point,:) = mean_projection;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.coll_points = mapping_to;
    end
    
    if strcmp(direction, 'CTOF')
        params.CTOF.field_points = mapping_to;
    end
    

    

