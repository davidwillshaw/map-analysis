function [x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
          x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to]  = ...
    get_complementary_ellipses(params, direction, ErrorType)
% GET_COMPLEMENTARY_ELLIPSES - Get properties of all complementary distributions
%
% See also find_overall_dispersion, get_centred_points


if (~exist('ErrorType'))
    ErrorType = 'sd'; % Other option is 'sem'
end

if strcmp(direction, 'CTOF')
    num_points       = params.CTOF.numpoints;
    radius           = params.coll_radius;
    full_from_coords = params.full_coll;
    full_to_coords   = params.full_field;
    from_centres     = params.CTOF.coll_points;
end

if strcmp(direction, 'FTOC')
    num_points       = params.FTOC.numpoints;
    radius           = params.field_radius;
    full_from_coords = params.full_field;
    full_to_coords   = params.full_coll;
    from_centres     = params.FTOC.field_points;
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
    centre = from_centres(point,:);
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
    if (strcmp(ErrorType, 'sem'))
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
