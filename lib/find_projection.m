function [from_points,projection_points] = find_projection(centre,radius,from_coords,to_coords)
% FIND_PROJECTION - find projection of a centre
% 
%   For coordinates CENTRE in a "from" structure, find the the
%   FROM_COORDS within a distance of RADIUS of the CENTRE, and the
%   corresponding TO_COORDS in the "to" structure.
  
    within_radius = find_within_radius(centre, radius, from_coords);
    from_points = from_coords(within_radius,:);
    projection_points = to_coords(within_radius,:);
  
% Local Variables:
% matlab-indent-level: 4
% matlab-indent-function-body: t
% End:
  