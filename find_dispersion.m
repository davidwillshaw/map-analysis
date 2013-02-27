function params = find_dispersion(params, direction)
% FIND_DISPERSION - Get dispersion (mean properties of the complementary distributions)
%   
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution.
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
%     params.stats.FTOC.dispersion_xrad - Mean length of major axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW1 in Willshaw et al. (2013), Table 3.
%
%     params.stats.FTOC.dispersion_yrad - Mean length of minor axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW2 in Willshaw et al. (2013), Table 3.
%
%     params.stats.FTOC.SEM_xrad - Mean length of major axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%     params.stats.FTOC.SEM_yrad - Mean length of minor axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
% See also plot_figure5, get_complmentary_ellipses

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sd');

if strcmp(direction,'CTOF')
    params.stats.CTOF.dispersion_xrad = mean(x_radius_to);
    params.stats.CTOF.dispersion_yrad = mean(y_radius_to);
end
   
if strcmp(direction,'FTOC')
    params.stats.FTOC.dispersion_xrad = mean(x_radius_to);
    params.stats.FTOC.dispersion_yrad = mean(y_radius_to);
end

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sem');

if strcmp(direction,'CTOF')
    params.stats.CTOF.SEM_xrad = mean(x_radius_to);
    params.stats.CTOF.SEM_yrad = mean(y_radius_to);
end
   
if strcmp(direction,'FTOC')
    params.stats.FTOC.SEM_xrad = mean(x_radius_to);
    params.stats.FTOC.SEM_yrad = mean(y_radius_to);
end


% Local Variables:
% matlab-indent-level: 4
% End:
