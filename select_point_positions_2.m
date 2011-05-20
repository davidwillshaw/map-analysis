function params = select_point_positions_2(params, direction)
%Selects params.numpoints point centres on the colliculus. At least 1/3 of
%the points within params.coll_radius must be active (though not the chosen
%point). Point centres must be separated by 2*radius and points are added
%until no more elligible points exist.
%
%Needs: params.pixels_in_ellipse,params.active_pixels, params.ellipse, 
%params.numpoints, params.coll_radius
%
%Returns: params.coll_points

    if strcmp(direction, 'CTOF')
        x_eligible = params.full_coll(:,1);
        y_eligible = params.full_coll(:,2);
        radius = params.coll_radius;
        min_points=(pi*radius^2)/3;
        x_active = params.full_coll(:,1);
        y_active = params.full_coll(:,2);
    end
    
    if strcmp(direction, 'FTOC')
        x_eligible = params.full_field(:,1);
        y_eligible = params.full_field(:,2);
        radius = params.field_radius;
        min_points = 10;
        x_active = params.full_field(:,1);
        y_active = params.full_field(:,2);
    end
    
    num_ellipse_pixels = length(x_eligible);
    min_spacing = radius*2;
    rand('twister', params.ranstart);
    
  
        chosen = zeros(500,2);
        num_points_selected = 0;
        ntry = 0;
        potential_points_x = x_eligible;
        potential_points_y = y_eligible;
        num_potential_points = num_ellipse_pixels;
        while num_potential_points > 0
            
            chosen_point = round(rand*(num_potential_points-1))+1;
            x_chosen = potential_points_x(chosen_point);
            y_chosen = potential_points_y(chosen_point);
            ntry = ntry + 1;
            distance_from_chosen_point = sqrt((x_chosen - x_active).^2 + ...
                (y_chosen - y_active).^2);
            %Check there are enough active points within the radius with
            %chosen centre
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
            distance_from_chosen = sqrt((potential_points_x - x_chosen).^2 + ...
                (potential_points_y-y_chosen).^2);
            points_in_radius = find(distance_from_chosen <= min_spacing);
            potential_points_x(points_in_radius) = [];
            potential_points_y(points_in_radius) = [];
            num_points_in_radius = length(points_in_radius);
            num_potential_points = num_potential_points - num_points_in_radius;
        end
    
    endpoint = find(chosen(:,1) == 0,1);
    chosen = chosen(1:(endpoint-1),:);
    [~, sort_index] = sort(chosen(:,1));
    chosen = chosen(sort_index,:);
    [~,area] = convhull(chosen(:,1),chosen(:,2));
    
    
    
    if strcmp(direction, 'CTOF')
        params.CTOF.numpoints = length(chosen);
        params.stats.CTOF.numpoints = length(chosen);
        params.CTOF.coll_points = chosen;
        %convert to mm^2
        area = area*(9*10^-3)^2;
        params.stats.CTOF.coll_area = area;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.numpoints = length(chosen);
        params.stats.FTOC.numpoints = length(chosen);
        params.FTOC.field_points = chosen;
        params.stats.FTOC.field_area = area;
    end
            
        
    