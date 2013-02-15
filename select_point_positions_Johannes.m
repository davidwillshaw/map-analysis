function params = select_point_positions(params, direction)
%Selects params.numpoints point centres on the colliculus. 

% Point centres must be separated by min_spacing, which is
%decreased if enough points can't be found within max_trials.
%
%Needs: params.pixels_in_ellipse,params.active_pixels, params.ellipse, 
%params.numpoints, params.coll_radius
%
%Returns: params.coll_points

%---------------------------------------------------------------------------
%    "x_eligible", "y_eligible" contain the coordinates of the 
%     starting list of points that can be chosen
%     Their origin depends on whether the points are selected from the
%     field ('FTOC') or the colliculus ('CTOF')

%    "numpoints" is the desired number of points

    if strcmp(direction, 'CTOF')
        x_eligible = params.full_coll(:,1);
        y_eligible = params.full_coll(:,2);
        numpoints = params.CTOF.numpoints;

    end
    
    if strcmp(direction, 'FTOC')
        x_eligible = params.full_field(:,1);
        y_eligible = params.full_field(:,2);
        numpoints = params.FTOC.numpoints;
    end
%--------------------------------------------------------------------------- 
%           set the starting minimum spacing "min_spacing"
%           to the number of points required" numpoints"
%	    also set the number of iterations tried at this spacing "max_trials"

    num_ellipse_pixels = length(x_eligible);
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

        potential_points_x = x_eligible;
        potential_points_y = y_eligible;
        num_potential_points = num_ellipse_pixels;

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

%-----------------------------------------------------------------------------
%     "chosen_point" gives the index of the chosen point
%    "x_chosen" and" y_chosen" are its coordinates

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

%     calculate are covered by chosen points
    [~,area] = convhull(chosen(:,1),chosen(:,2));
    
    
    if strcmp(direction, 'CTOF')
        params.CTOF.coll_points = chosen;
        params.stats.CTOF.coll_area = area;
    end
    
    if strcmp(direction, 'FTOC')
        params.FTOC.field_points = chosen;
        params.stats.FTOC.field_area = area;
    end
            
        
    
