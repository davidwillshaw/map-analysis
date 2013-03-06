function h = plot_lattice(params, direction, h1, h2, varargin)
% PLOT_LATTICE - General Lattice-plotting function
%   
%   Plot params in direction into handles h1 and h2


if (nargin > 4) 
    p = validateInput(varargin, {'ErrorType', 'AxisStyle', 'Subgraph'});
else
    p = struct();
end

AxisStyle = 'crosshairs'; % Other option is 'box'
if (isfield(p, 'AxisStyle'))
    AxisStyle = p.AxisStyle;
end
ErrorType = 'none'; % Other options are 'sem'
if (isfield(p, 'ErrorType'))
    ErrorType = p.ErrorType;
end
Subgraph = false; % Other option is 'sem'
if (isfield(p, 'Subgraph'))
    ErrorType = p.Subgraph
end

% Clear axes
subplot(h1)
cla
subplot(h2)
cla

if (~strcmp(ErrorType, 'none'))
    if (strcmp(direction, 'FTOC'))
        [x_cent_f, y_cent_f, angle_f, x_radius_f, y_radius_f, ...
         x_cent_c, y_cent_c, angle_c, x_radius_c, y_radius_c] = ...
            get_complementary_ellipses(params, 'FTOC', ErrorType, Subgraph);
    else
        [x_cent_c, y_cent_c, angle_c, x_radius_c, y_radius_c, ...
         x_cent_f, y_cent_f, angle_f, x_radius_f, y_radius_f] = ...
            get_complementary_ellipses(params, 'CTOF', ErrorType, Subgraph);
    end
    num_points = length(angle_f);
    % Ellipse plots
    for point = 1:num_points
        subplot(h1)
        ellipse(x_radius_f(point), y_radius_f(point), -angle_f(point), ...
                x_cent_f(point),   y_cent_f(point)  , 'k');
        hold on
        subplot(h2)
        ellipse(x_radius_c(point), y_radius_c(point), -angle_c(point), ...
                x_cent_c(point),   y_cent_c(point), 'k');
        hold on
    end
end
    
% Set axis properties for FTOC Field ellipse plot
subplot(h1)
hold on
if (strcmp(AxisStyle, 'crosshairs'))
    draw_crosshairs(params.field);
    axis off
    draw_scalebar(params.field)
else
    set(gca, 'FontSize', 16)
    axis on
end
set_axis_props(params.field)
title(params.field.title);
xlabel(params.field.xlabel);
ylabel(params.field.ylabel);

% Set axis properties for FTOC colliculus ellipse plot
subplot(h2)
hold on
if (strcmp(AxisStyle, 'crosshairs'))
    axis off
    draw_scalebar(params.coll)
else
    set(gca, 'FontSize', 16)
    axis on
end
set_axis_props(params.coll)
title(params.coll.title);
xlabel(params.coll.xlabel);
ylabel(params.coll.ylabel);

end

function draw_crosshairs(s) 
% Draw crosshairs, given structure s, which can be params.field or
% params.coll. If drawScalebar is true, draw the scalebar.
    xmin = s.XLim(1);
    xmax = s.XLim(2);
    ymin = s.YLim(1);
    ymax = s.YLim(2);
    plot([s.xmean s.xmean], ...
         [ymin ymax], ...
         'Color',[0.7 0.7 0.7], 'Linewidth',1)
    hold on
    plot([xmin xmax], ...
         [s.ymean s.ymean],  ...
         'Color',[0.7 0.7 0.7], 'Linewidth',1)
end

% Local Variables:
% matlab-indent-level: 4
% End:
