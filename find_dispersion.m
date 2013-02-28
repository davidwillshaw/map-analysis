function params = find_dispersion(params, direction, subgraph)
% FIND_DISPERSION - Get dispersion (mean properties of the complementary distributions)
%   
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution. This function finds properties of
%   these distributions. If subgraph is true, this function finds
%   properties of these distributions for points in the maximum
%   ordered subgraph.
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
%     params.stats.direction.dispersion_xrad - Mean length of major axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW1 in Willshaw et al. (2013), Table 3.
%
%     params.stats.direction.dispersion_yrad - Mean length of minor axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW2 in Willshaw et al. (2013), Table 3.
%
%     params.stats.direction.SEM_xrad - Mean length of major axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%     params.stats.direction.SEM_yrad - Mean length of minor axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%  With subgraph = false these are:
%
%     params.stats.direction.subgraph_dispersion_xrad - Mean length of major axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW1 in Willshaw et al. (2013), Table 3.
%
%     params.stats.direction.subgraph_dispersion_yrad - Mean length of minor axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW2 in Willshaw et al. (2013), Table 3.
%
%     params.stats.direction.subgraph_SEM_xrad - Mean length of major axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%     params.stats.direction.subgraph_SEM_yrad - Mean length of minor axes of
%       ellipses fitted to standard error in mean of complementary
%       distributions.
%
%
% See also plot_figure5, get_complmentary_ellipses, find_subgraph_dispersion

if (~exist('subgraph')) 
    subgraph = false;
end

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sd', subgraph);

if strcmp(direction,'CTOF')
    if (subgraph) 
        params.stats.CTOF.subgraph_dispersion_xrad = mean(x_radius_to);
        params.stats.CTOF.subgraph_dispersion_yrad = mean(y_radius_to);
    else
        params.stats.CTOF.dispersion_xrad = mean(x_radius_to);
        params.stats.CTOF.dispersion_yrad = mean(y_radius_to);
    end
end
   
if strcmp(direction,'FTOC')
    if (subgraph) 
        params.stats.FTOC.subgraph_dispersion_xrad = mean(x_radius_to);
        params.stats.FTOC.subgraph_dispersion_yrad = mean(y_radius_to);
    else
        params.stats.FTOC.dispersion_xrad = mean(x_radius_to);
        params.stats.FTOC.dispersion_yrad = mean(y_radius_to);
    end
end

[x_cent_from, y_cent_from, angle_from, x_radius_from, y_radius_from, ...
 x_cent_to,   y_cent_to,   angle_to,   x_radius_to,   y_radius_to] = ...
    get_complementary_ellipses(params, direction, 'sem', subgraph);

if strcmp(direction,'CTOF')
    if (subgraph) 
        params.stats.CTOF.subgraph_SEM_xrad = mean(x_radius_to);
        params.stats.CTOF.subgraph_SEM_yrad = mean(y_radius_to);
    else
        params.stats.CTOF.SEM_xrad = mean(x_radius_to);
        params.stats.CTOF.SEM_yrad = mean(y_radius_to);
    end
end
   
if strcmp(direction,'FTOC')
    if (subgraph) 
        params.stats.FTOC.subgraph_SEM_xrad = mean(x_radius_to);
        params.stats.FTOC.subgraph_SEM_yrad = mean(y_radius_to);
    else
        params.stats.FTOC.SEM_xrad = mean(x_radius_to);
        params.stats.FTOC.SEM_yrad = mean(y_radius_to);
    end
end

% Local Variables:
% matlab-indent-level: 4
% End:
