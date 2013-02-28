function cum_centred_points = get_centred_points(params, direction, ...
                                                         subgraph)
% GET_CENTRED_POINTS - Get positions of all points relative to their point centres
%
%   ARGUMENTS:
%
%   params: params structure
%
%   direction: 'CTOF' or 'FTOC'
%
%   subgraph: If true extract information only for points in the
%   maximally-ordered subgraph

% See also find_overall_dispersion, get_centred_points

if (~exist('subgraph'))
    subgraph = false; % Other option is 'sem'
end

if strcmp(direction,'CTOF')
    pos              = params.CTOF.points_in_subgraph;
    num_points       = params.CTOF.numpoints;
    radius           = params.coll_radius;
    full_from_coords = params.full_coll;
    full_to_coords   = params.full_field;
    from_centres     = params.CTOF.coll_points;
end

if strcmp(direction,'FTOC')
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

cum_centred_points = [];
for point = 1:num_points
    centre = from_centres(pos(point),:);
    [from_points, projection_points] = find_projection(centre, ...
                                                      radius, ...
                                                      full_from_coords, full_to_coords);
    num_projection = length(projection_points);
    centred_points = projection_points - ...
        repmat(mean(projection_points), num_projection, 1);
    cum_centred_points = [cum_centred_points; centred_points];
end

% Local Variables:
% matlab-indent-level: 4
% End:
