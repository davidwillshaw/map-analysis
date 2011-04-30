function params = select_point_positions(params, direction)
%Selects params.numpoints point centres on the colliculus. At least 1/3 of
%the points within params.coll_radius must be active (though not the chosen
%point). Point centres must be separated by min_spacing though this is
%decreased enough points can't be found within max_trials.
%
%Needs: params.pixels_in_ellipse,params.active_pixels, params.ellipse, 
%params.numpoints, params.coll_radius
%
%Returns: params.coll_points

    if strcmp(direction, 'CTOF')
        [y_eligible,x_eligible] = find(params.pixels_in_ellipse);
        numpoints = params.CTOF.numpoints;
        area = pi*params.ellipse.ra*params.ellipse.rb;
        radius = params.coll_radius;
        min_points=(pi*radius^2)/3;
        x_active = params.full_coll(:,1);
        y_active = params.full_coll(:,2);
    end
    
    if strcmp(direction, 'FTOC')
        x_eligible = params.full_field(:,1);
        y_eligible = params.full_field(:,2);
        numpoints = params.FTOC.numpoints;
        area = (max(y_eligible) - min(y_eligible))* ...
            (max(x_eligible) - min(x_eligible));
        radius = params.field_radius;
        min_points = 10;
        x_active = params.full_field(:,1);
        y_active = params.full_field(:,2);
    end
    
    num_ellipse_pixels = length(x_eligible);
    min_spacing = 0.75*sqrt(area/numpoints);
    max_trials = numpoints*100;
    rand('twister', params.ranstart);
    num_points_selected = 0;
    
    while num_points_selected < numpoints
        chosen = zeros(numpoints,2);
        min_spacing = 0.95*min_spacing;
        num_points_selected = 0;
        ntry = 0;
        potential_points_x = x_eligible;
        potential_points_y = y_eligible;
        num_potential_points = num_ellipse_pixels;
        while num_points_selected < numpoints && ntry <= max_trials ...
                && num_potential_points > 0
            
            chosen_point = round(rand*(num_potential_points-1))+1;
            x_chosen = potential_points_x(chosen_point);
            y_chosen = potential_points_y(chosen_point);
            ntry = ntry + 1;
            distance_from_chosen_point = sqrt((x_chosen - x_active).^2 + ...
                (y_chosen - y_active).^2);
            %Check there are enough active points within the radius with
            %chosen centre
            num_active_within_radius = sum(distance_from_chosen_point < ...
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
            points_in_radius = find(distance_from_chosen < min_spacing);
            potential_points_x(points_in_radius) = [];
            potential_points_y(points_in_radius) = [];
            num_points_in_radius = length(points_in_radius);
            num_potential_points = num_potential_points - num_points_in_radius;
        end
    end
    
    [~, sort_index] = sort(chosen(:,1));
    chosen = chosen(sort_index,:);
    
    if strcmp(direction, 'CTOF')
        params.CTOF.coll_points = chosen;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.field_points = chosen;
    end
            
        
    