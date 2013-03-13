function params = select_point_positions(params, direction)
% SELECT_POINT_POSITIONS - Selects point centres on a structure 
%   
%   If direction is 'CTOF', choose params.CTOF.numpoints
%   representative points out of the points on the colliculus
%   params.full_coll, subject to the following constraints:
%
%   (1) The miniumum spacing between nearest neighbours should be
%   min_spacing, initially set to 0.75*sqrt(area/numpoints), which is
%   decreased in steps if enough points can't be found within
%   max_trials=numpoints*100. area is derived from the convex hull
%   of params.full_coll 
% 
%   (2) There have to be at least params.coll_min_points points within
%   params.coll_radius of each chosen location, which is the extent
%   over which smoothing took place.
%     
%   The chosen point locations are put in params.CTOF.coll_points. The
%   area of the convex hull of these locations is put in
%   params.stats.CTOF.coll_area. The area is scaled by a factor
%   (params.coll.scale)^2.
%    
%   If the direction is 'FTOC', params.FTOC.numpoints points are
%   chosen from params.FTOC.full_field using the parameters
%   params.field_min_points and params.field_radius.  The chosen
%   points are put in params.FTOC.field_points and the area of the
%   convex hull of the chosen points in
%   params.stats.FTOC.field_area. The area is scaled by a factor
%   (params.field.scale)^2.
%    
%   Needs: params.full_field, params.full_coll, params.CTOF.numpoints,
%   params.FTOC.numpoints, params.coll_radius, params.field_radius,
%   params.coll.scale, params.field.scale
%    
%   Returns: If direction is 'CTOF' params.CTOF.coll_points and
%   params.stats.CTOF.coll_area.  If direction is 'FTOC',
%   params.FTOC.field_points and params.stats.FTOC.field_area.
%    

%---------------------------------------------------------------------------
%    "x_active", "y_active" contain the coordinates of the 
%     starting list of points that can be chosen
%     Their origin depends on whether the points are selected from the
%     field ('FTOC') or the colliculus ('CTOF')

%    "numpoints" is the desired number of points

    if strcmp(direction, 'CTOF')
        x_active = params.full_coll(:,1);
        y_active = params.full_coll(:,2);
        numpoints = params.CTOF.numpoints;
        min_points = params.coll_min_points;
        radius = params.coll_radius;
    end
    
    if strcmp(direction, 'FTOC')
        x_active = params.full_field(:,1);
        y_active = params.full_field(:,2);
        numpoints = params.FTOC.numpoints;
        min_points = params.field_min_points;
        radius = params.field_radius;
    end

    %------------------------------------------------------------------------
    % set the starting minimum spacing "min_spacing" to the number of
    % points required "numpoints"
    %
    % also set the number of iterations tried at this spacing
    % "max_trials"

    [~,area] = convhull(x_active, y_active);
    min_spacing = 0.75*sqrt(area/numpoints);
    max_trials = numpoints*100;
    rand('twister', params.ranstart);
    num_points_selected = 0;

%---------------------------------------------------------------------------
%          coordinates of points chosen contained in "chosen"
    while num_points_selected < numpoints
        chosen = zeros(numpoints,2);
%   here is the step where the min_spacing is reduced
        min_spacing = 0.95*min_spacing;
        num_points_selected = 0;
        ntry = 0;

%--------------------------------------------------------------------------
%	"potential_points_x" and "potential_points_y" hold the
%       coordinates of all the points that can be selected from

        potential_points_x = x_active;
        potential_points_y = y_active;
        num_potential_points = length(x_active);
        
%--------------------------------------------------------------------------
%     if the required number of points have not yet been chosen
%     and the number of trials allowed is not exceeded
%     and there are still some points to be chosen from
%     then choose a new point

        while num_points_selected < numpoints && ntry <= max_trials ...
                && num_potential_points > 0
            
            chosen_point = round(rand*(num_potential_points-1))+1;
            x_chosen = potential_points_x(chosen_point);
            y_chosen = potential_points_y(chosen_point);
            ntry = ntry + 1;
            
            %--------------------------------------------------------------
            % The min_points test
            %     "chosen_point" gives the index of the chosen point
            %    "x_chosen" and" y_chosen" are its coordinates
            distance_from_chosen_point = sqrt((x_chosen - x_active).^2 + ...
                                              (y_chosen - y_active).^2);
            % Check there are enough active points within the
            % radius with chosen centre
            num_active_within_radius = sum(distance_from_chosen_point <= ...
                                           radius);
            if num_active_within_radius < min_points
                potential_points_x(chosen_point) = [];
                potential_points_y(chosen_point) = [];
                num_potential_points = num_potential_points - 1;
                continue
            end

            num_points_selected = num_points_selected + 1;
            chosen(num_points_selected,1) = x_chosen;
            chosen(num_points_selected,2) = y_chosen;

%-----------------------------------------------------------------------------
%     now select all the points within a distance of <min_spacing> 
%    of the chosen point and remove mention of them from
%    "potential_points_x" and "potential_points_y"

            distance_from_chosen = sqrt((potential_points_x - x_chosen).^2 + ...
                (potential_points_y-y_chosen).^2);
            points_in_radius = find(distance_from_chosen <= min_spacing);
            potential_points_x(points_in_radius) = [];
            potential_points_y(points_in_radius) = [];
            num_points_in_radius = length(points_in_radius);
            num_potential_points = num_potential_points -num_points_in_radius;

%    then go back and find another point
        end

%   if a satisfactory set of points have not been chosen
%   decrease min_spacing and start again
    end
    

%---------------------------------------------------------------------------------------
    [~, sort_index] = sort(chosen(:,1));
    chosen = chosen(sort_index,:);

%     calculate area covered by chosen points
    [~,area] = convhull(chosen(:,1),chosen(:,2));
    
    
    if strcmp(direction, 'CTOF')
        params.CTOF.coll_points = chosen;
        area = area*params.coll.scale^2;
        params.stats.CTOF.coll_area = area;

        params.CTOF.set_min_spacing = min_spacing;     
        choose_dists = dist(chosen')+ 100*eye(numpoints);
        params.CTOF.mean_min_spacing = mean(min(choose_dists))*numpoints/(numpoints-1);
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.field_points = chosen;
        area = area*params.field.scale^2;
        params.stats.FTOC.field_area = area;

        params.FTOC.set_min_spacing = min_spacing;     
        choose_dists = dist(chosen')+ 100*eye(numpoints);
        params.FTOC.mean_min_spacing = mean(min(choose_dists))*numpoints/(numpoints-1);
    end
            
% Local Variables:
% matlab-indent-level: 4
% End:
        
    
