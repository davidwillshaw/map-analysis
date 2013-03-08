function params = find_overall_dispersion(params, direction, subgraph)
% FIND_OVERALL_DISPERSION - Get overall dispersion (properties of the superposed distribution)
%   
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution.  If subgraph is true, this function
%   finds properties of these distributions for points in the maximum
%   ordered subgraph.
%    
%   A view of the overall pattern of complementary distributions in a
%   given data set can be gained by superposing on the same plot the
%   individual complementary distributions from all the chosen
%   locations after transforming them to a common origin and then
%   modelling the superposed distribution as a 2D Gaussian. The
%   ellipse with subaxes of lengths equal to the standard deviations
%   in the directions of these axes encloses 68.5% of all the points
%   in the superposed distribution.
%
%   ARGUMENTS:
%
%   params: params structure. The following fields are read from the
%       params structure: params.ellipse, params.FTOC.numpoints,
%       params.CTOF.numpoints, params.full_field, params.full_coll,
%       params.field_radius, params.coll_radius.
%
%   direction: 'CTOF' or 'FTOC'
% 
%   subgraph: If true extract information only for points in the
%       maximally-ordered subgraph
%
%   OUTPUTS
%    
%   Various fields are added to params ('direction' is 'FTOC' or
%   'CTOF'). With subgraph = false, these are:    
%       
%   - Properties of the superposed distribution (also referred to as
%     "overall complementary distribution"; see Table 5 in Willshaw et
%     al., 2013):
%
%     params.stats.direction.overall_dispersion_xrad - Length of major axis
%       ellipse fitted to superposed distribution
%
%     params.stats.direction.overall_dispersion_yrad - Length of minor axis
%       ellipse fitted to superposed distribution
%
%     params.stats.direction.overall_dispersion_angle - Angle of major axis
%       of ellipse. The zero degree line is defined on the colliculus
%       as rostral to caudal and in the visual field as temporal to
%       nasal. Clockwise rotations are positive.
%
%  With subgraph = false these are:
%
%     params.stats.direction.subgraph_overall_dispersion_xrad - Length of major axis
%       ellipse fitted to superposed distribution
%
%     params.stats.direction.subgraph_overall_dispersion_yrad - Length of minor axis
%       ellipse fitted to superposed distribution
%
%     params.stats.direction.subgraph_overall_dispersion_angle - Angle of major axis
%       of ellipse. The zero degree line is defined on the colliculus
%       as rostral to caudal and in the visual field as temporal to
%       nasal. Clockwise rotations are positive.
%
% See also plot_figure3, get_centred_points

if (~exist('subgraph')) 
    subgraph = false;
end

cum_centred_points = get_centred_points(params, direction);
[angle, x_radius, y_radius] = ...
    plot_error_ellipse(cum_centred_points);

if strcmp(direction,'CTOF')
    if (subgraph) 
        params.stats.CTOF.subgraph_overall_dispersion_xrad = x_radius;
        params.stats.CTOF.subgraph_overall_dispersion_yrad = y_radius;
        params.stats.CTOF.subgraph_overall_dispersion_angle = -angle;
    else
        params.stats.CTOF.overall_dispersion_xrad = x_radius;
        params.stats.CTOF.overall_dispersion_yrad = y_radius;
        params.stats.CTOF.overall_dispersion_angle = -angle;
    end
end
   
if strcmp(direction,'FTOC')
    if (subgraph)     
        params.stats.FTOC.subgraph_overall_dispersion_xrad = x_radius;
        params.stats.FTOC.subgraph_overall_dispersion_yrad = y_radius;
        params.stats.FTOC.subgraph_overall_dispersion_angle = -angle;
    else
        params.stats.FTOC.overall_dispersion_xrad = x_radius;
        params.stats.FTOC.overall_dispersion_yrad = y_radius;
        params.stats.FTOC.overall_dispersion_angle = -angle;
    end
end

% Local Variables:
% matlab-indent-level: 4
% End:
