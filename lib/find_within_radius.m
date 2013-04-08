function within_radius = find_within_radius(centre, radius, coords)
% FIND_WITHIN_RADIUS - Find indicies of points within radius of centre
%   
%   For coordinates CENTRE, find indicies of points of COORDS
%   within a distance of RADIUS.

    distance_from_centre = sqrt((coords(:,1) - centre(1)).^2 + ...
                                (coords(:,2) - centre(2)).^2);
    within_radius = distance_from_centre <= radius;

% Local Variables:
% matlab-indent-level: 4
% matlab-indent-function-body: t
% End:
