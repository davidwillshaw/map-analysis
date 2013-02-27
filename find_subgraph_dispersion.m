function params = find_subgraph_dispersion(params, direction)
% FIND_SUBGRAPH_DISPERSION - Get dispersion for subgraphs (mean properties of the complementary distributions)
%   
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution. This function finds properties of
%   these distributions for points in the maximum ordered subgraph.
%
%   INPUTS 
%   
%   The following fields are read from the params structure:
%   params.ellipse, params.FTOC.numpoints, params.CTOF.numpoints,
%   params.full_field, params.full_coll, params.field_radius,
%   params.coll_radius. Plotting properties are controlled by the
%   variables in params.coll and params.field - see getparams.m for
%   description.
%    
%   OUTPUTS
%    
%   Various fields are added to params:    
%    
%     params.stats.FTOC.subgraph_dispersion_xrad - Mean length of major axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW1 in Willshaw et al. (2013), Table 3.
%
%     params.stats.FTOC.subgraph_dispersion_yrad - Mean length of minor axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW2 in Willshaw et al. (2013), Table 3.
%
%     params.stats.FTOC.subgraph_SEM_xrad - Mean length of major axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%     params.stats.FTOC.subgraph_SEM_yrad - Mean length of minor axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
% See also plot_figure5, get_complmentary_ellipses, find_dispersion

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sd', true);

if strcmp(direction,'CTOF')
    params.stats.CTOF.subgraph_dispersion_xrad = mean(x_radius_to);
    params.stats.CTOF.subgraph_dispersion_yrad = mean(y_radius_to);
end
   
if strcmp(direction,'FTOC')
    params.stats.FTOC.subgraph_dispersion_xrad = mean(x_radius_to);
    params.stats.FTOC.subgraph_dispersion_yrad = mean(y_radius_to);
end

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sem', true);

if strcmp(direction,'CTOF')
    params.stats.CTOF.subgraph_SEM_xrad = mean(x_radius_to);
    params.stats.CTOF.subgraph_SEM_yrad = mean(y_radius_to);
end
   
if strcmp(direction,'FTOC')
    params.stats.FTOC.subgraph_SEM_xrad = mean(x_radius_to);
    params.stats.FTOC.subgraph_SEM_yrad = mean(y_radius_to);
end

% Local Variables:
% matlab-indent-level: 4
% End:
