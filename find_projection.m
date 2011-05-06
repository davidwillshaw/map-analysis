function projection_points = find_projection(centre,radius,from_coords,to_coords)

   distance_from_centre = sqrt((from_coords(:,1) - centre(1)).^2 + ...
       (from_coords(:,2) - centre(2)).^2);
   within_radius = distance_from_centre < radius;
   projection_points = to_coords(within_radius,:);