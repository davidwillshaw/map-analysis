function [x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
          x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to]  = ...
    get_complementary_ellipses(params, direction, error_type, subgraph)
% GET_COMPLEMENTARY_ELLIPSES - Get properties of all complementary distributions
%
%   Extract the centres, angles of radii of ellipses describing the
%   complementary distributions of corresponding centres in the lattice.
%
%   ARGUMENTS:
%
%   params: params structure
%
%   direction: 'CTOF' or 'FTOC'
% 
%   error_type: If 'sd' (default), extract standard deviation of
%       complementary distributions (as in Figure 5 of Willshaw et
%       al. 2013). If 'sem', extract standard errors in the mean of
%       complementary distributions (as in Figure 7C of Willshaw et
%       al. 2013).
%
%   subgraph: If true extract information only for points in the
%   maximally-ordered subgraph
%
% See also find_dispersion, get_centred_points


if (~exist('error_type'))
    error_type = 'sd'; % Other option is 'sem'
end
if (~exist('subgraph'))
    subgraph = false; % Other option is 'sem'
end


if strcmp(direction, 'CTOF')
    pos              = params.CTOF.points_in_subgraph;
    num_points       = params.CTOF.numpoints;
    radius           = params.coll_radius;
    full_from_coords = params.full_coll;
    full_to_coords   = params.full_field;
    from_centres     = params.CTOF.coll_points;
end

if strcmp(direction, 'FTOC')
    pos              = params.FTOC.points_in_subgraph;
    num_points       = params.FTOC.numpoints;
    radius           = params.field_radius;
    full_from_coords = params.full_field;
    full_to_coords   = params.full_coll;
    from_centres     = params.FTOC.field_points;
end

if (subgraph)
    num_points = length(pos);
else
    pos = 1:num_points;
end

x_cent_from   = zeros(num_points, 1);
y_cent_from   = zeros(num_points, 1);
angle_from    = zeros(num_points, 1);
x_radius_from = zeros(num_points, 1);
y_radius_from = zeros(num_points, 1);

x_cent_to     = zeros(num_points, 1);
y_cent_to     = zeros(num_points, 1);
angle_to      = zeros(num_points, 1);
x_radius_to   = zeros(num_points, 1);
y_radius_to   = zeros(num_points, 1);

for point = 1:num_points
    centre = from_centres(pos(point),:);
    [from_points, to_points] = ... 
        find_projection(centre, radius, ...
                        full_from_coords, full_to_coords);
    x_cent_from(point) = mean(from_points(:,1));
    y_cent_from(point) = mean(from_points(:,2));
    x_cent_to(point)   = mean(to_points(:,1));
    y_cent_to(point)   = mean(to_points(:,2));
    
    [angle_from(point), x_radius_from(point), y_radius_from(point)] = ...
        plot_error_ellipse(from_points);
    [angle_to(point),   x_radius_to(point),   y_radius_to(point)] = ...
        plot_error_ellipse(to_points);
    
    num_projection = length(to_points);
    if (strcmp(error_type, 'sem'))
        % compute standard errors of mean 
        x_radius_from(point) = x_radius_from(point)/sqrt(num_projection);
        y_radius_from(point) = y_radius_from(point)/sqrt(num_projection);
        x_radius_to(point) = x_radius_to(point)/sqrt(num_projection);
        y_radius_to(point) = y_radius_to(point)/sqrt(num_projection);
    end
end

% Local Variables:
% matlab-indent-level: 4
% End:
