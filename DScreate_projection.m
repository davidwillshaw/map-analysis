function params = DScreate_projection(params, direction)
% Takes in a list of all eligible points, a list of point centres and a
% direction of mapping and returns the mean projection of each point.

    if strcmp(direction, 'RTOC')
        set_points = params.RTOC.ret_points;
        set_points(params.RTOC.takeout,:) = [];
        from_coords = params.full_ret;
        to_coords = params.full_coll;
        num_points = params.RTOC.numpoints;
        radius = params.ret_radius;
    end
    
    if strcmp(direction, 'CTOR')
        set_points = params.CTOR.coll_points;
        set_points(params.CTOR.takeout,:) = [];
        from_coords = params.full_coll;
        to_coords = params.full_ret;
        radius = params.coll_radius;
        num_points = params.CTOR.numpoints;
    end
 
    projected_points = zeros(num_points,2);
    
    for point = 1:num_points
        centre = set_points(point,:);
        [~,all_projected_points] = find_projection(centre,radius,from_coords,to_coords);

        mean_projection = mean(all_projected_points);
        projected_points(point,:) = mean_projection;
    end
    
    [~,area] = convhull(projected_points(:,1),projected_points(:,2));
    
    if strcmp(direction, 'RTOC')
%    projected_points(:,2) = projected_points(randperm(num_points),2);

        params.RTOC.coll_points = projected_points;
	params.RTOC.mean_projection = projected_points;
        params.stats.RTOC.coll_area = area;
    end
    
    if strcmp(direction, 'CTOR')
%   projected_points(:,2) = projected_points(randperm(num_points),2);
        params.CTOR.ret_points = projected_points;
        params.stats.CTOR.ret_area = area;
    end
    

%params.stats.RTOC 
%params.stats.CTOR

