function params = create_projection(params, direction)
% Takes in a list of all active points, a lits of point centres and a
% direction of mapping and returns the mean projection of each point.

    if strcmp(direction, 'FTOC')
        set_points = params.FTOC.field_points;
        set_points(params.FTOC.takeout,:) = [];
        from_coords = params.full_field;
        to_coords = params.full_coll;
        num_points = params.FTOC.numpoints;
        radius = params.field_radius;
    end
    
    if strcmp(direction, 'CTOF')
        set_points = params.CTOF.coll_points;
        set_points(params.CTOF.takeout,:) = [];
        from_coords = params.full_coll;
        to_coords = params.full_field;
        radius = params.coll_radius;
        num_points = params.CTOF.numpoints;
    end
    
    projected_points = zeros(num_points,2);
    
    for point = 1:num_points
        centre = set_points(point,:);
        [~,all_projected_points] = find_projection(centre,radius,from_coords,to_coords);
        mean_projection = mean(all_projected_points);
        projected_points(point,:) = mean_projection;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.coll_points = projected_points;
    end
    
    if strcmp(direction, 'CTOF')
        params.CTOF.field_points = projected_points;
    end
    

    

