function params = Dremove_more_pixels(params,params_old, TAKEOUT)
% Takes in a list of all active pixels and a list of point centres
% Removes all active pixels from the regions surrounding these centres.
%  looks like first argument in active_pixels relates to 
%  second argument in coordinate lists

    active_pixels = params.active_pixels;
    I = find(active_pixels==1);
    length(I)

        set_points = params_old.CTOF.coll_points;
        set_points(params.CTOF.takeout,:) = [];
        from_coords = params_old.full_coll;
        to_coords = params_old.full_field;
        radius = params_old.coll_radius;
        num_points = length(TAKEOUT);
        
    for point = 1:num_points
        centre = set_points(TAKEOUT(point),:);
        distance_from_centre = sqrt((from_coords(:,1) - centre(1)).^2 + ...
       (from_coords(:,2) - centre(2)).^2);
        within_radius = distance_from_centre <= radius;
        from_points = from_coords(within_radius,:);
	[centre(1) centre(2)];
        active_pixels(centre(2),centre(1))=0;
	for ii=1:length(from_points(:,1))
             active_pixels(from_points(ii,2),from_points(ii,1))= 0;
        end
    end
    
 	I = find(active_pixels==1);
        length(I)      

	params.active_pixels = active_pixels;
        params.num_active_pixels = length(find(active_pixels == 1));
        params.stats.num_active_pixels = length(find(active_pixels == 1));
     
