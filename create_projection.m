function params = create_projection(params, direction)
% CREATE_PROJECTION - Find mean projection of points from one
%   structure on another
%     
%   In 'FTOC' direction, takes in a list params.FTOC.full_field of
%   all active field points, a list of corresponding points in the
%   colliculus params.FTOC.full_coll, and a list of point centres
%   params.FTOC.field_points and returns the mean projection
%   params.FTOC.coll_points of each point. Indices of point centres to
%   take out can be specified with params.FTOC.takeout. The area of
%   the convex hull of the chosen points in
%   params.stats.FTOC.coll_area. The area is scaled by a factor
%   (params.coll_scale)^2.
% 
%   The functions works analagously in the 'CTOF' direction.
%    

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
    
    [~,area] = convhull(projected_points(:,1),projected_points(:,2));
    
    if strcmp(direction, 'FTOC')
        % projected_points(:,2) = projected_points(randperm(num_points),2);

        params.FTOC.coll_points = projected_points;
        % FIXME: Do we need to set params.FTOC.mean_projection?
        params.FTOC.mean_projection = projected_points;
        area = area*params.coll_scale^2;
        params.stats.FTOC.coll_area = area;
    end
    
    if strcmp(direction, 'CTOF')
        % projected_points(:,2) = projected_points(randperm(num_points),2);
        params.CTOF.field_points = projected_points;
        area = area*params.field_scale^2;        
        params.stats.CTOF.field_area = area;
    end
    
% Local Variables:
% matlab-indent-level: 4
% End:
