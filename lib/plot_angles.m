function h = plot_angles(params, direction, h, varargin)
% PLOT_ANGLES - Plot angle distribution
%   
if (nargin > 3) 
    p = validateInput(varargin, {'AxisStyle', 'Subgraph', ...
                        'Colour'});
else
    p = struct();
end

Subgraph = false; % Other option is 'sem'
if (isfield(p, 'Subgraph'))
    Subgraph = p.Subgraph;
end

if strcmp(direction,'CTOF')
    color = 'b';
else
    color = 'k';
end
if isfield(p, 'Colour')
    color = p.Colour;
end

if (~Subgraph)
    if (strcmp(direction, 'FTOC')) 
        angles = -params.FTOC.angles;
        norm_links = params.FTOC.norm_links;
        flipped_links = params.FTOC.flipped_links;
    else
        angles = -params.CTOF.angles;
        norm_links = params.CTOF.norm_links;
        flipped_links = params.CTOF.flipped_links;
    end
else
    if (strcmp(direction, 'FTOC')) 
        angles = -params.FTOC.subgraph_angles;
        norm_links = params.FTOC.subgraph_norm_links;
        flipped_links = params.FTOC.subgraph_flipped_links;
    else
        angles = -params.CTOF.subgraph_angles;
        norm_links = params.CTOF.subgraph_norm_links;
        flipped_links = params.CTOF.subgraph_flipped_links;
    end
end

circ_plot(angles(norm_links>0), 'hist', color, 40, false, true, ...
          'linewidth', 2, 'color', color);
hold on
circ_plot(angles(flipped_links>0),'hist', 'r', 40, false, true, ...
          'linewidth', 2, 'color', 'r');
title(params.datalabel);    

% Local Variables:
% matlab-indent-level: 4
% End:
