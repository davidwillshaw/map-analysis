function params = plot_figure5(params, varargin)
% PLOT_FIGURE5 - Plot complementary distributions
%       
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution.
%
%   This function plots the complementary distributions for each node
%   in the lattice in the FTOC and CTOF directions. The following
%   properties control what is plotted and the appearance of the
%   plot:
%   
%   - ErrorType: If 'sd' (default), plot standard deviation of
%       complementary distributions (as in Figure 5 of Willshaw et
%       al. 2013). If 'sem', plot standard errors in the mean of
%       complementary distributions (as in Figure 7C of Willshaw et
%       al. 2013).
%
%   - AxisStyle: If 'crosshairs' (default), plot crosshairs and
%       scalebars (as in all figures in Willshaw et al. 2013). If
%       'box', plot conventional axes.
%    
%   - Subgraph: If true, plot only distributions around points in the
%       maxium subgraph; otherwise plot all distributions.
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
%   - If 'ErrorType' is 'sd', mean properties of the complementary
%     distributions: 
%    
%     params.stats.FTOC.dispersion_xrad - Mean length of major axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW1 in Willshaw et al. (2013), Table 3.
%
%     params.stats.FTOC.dispersion_yrad - Mean length of minor axes
%       of ellipses fitted to complementary distributions, referred
%       to as SDW2 in Willshaw et al. (2013), Table 3.
%
% See also plot_figure3

    if (nargin >= 1) 
        p = validateInput(varargin, {'ErrorType', 'AxisStyle', 'Subgraph'});
    else
        p = struct();
    end
    
    AxisStyle = 'crosshairs'; % Other option is 'box'
    if (isfield(p, 'AxisStyle'))
        AxisStyle = p.AxisStyle;
    end
    ErrorType = 'sd'; % Other option is 'sem'
    if (isfield(p, 'ErrorType'))
        ErrorType = p.ErrorType;
    end
    Subgraph = false; % Other option is 'sem'
    if (isfield(p, 'ErrorType'))
        ErrorType = p.Subgraph
    end

    figure(5)
    clf

    %FTOC

    [x_cent_f, y_cent_f, angle_f, x_radius_f, y_radius_f, ...
     x_cent_c, y_cent_c, angle_c, x_radius_c, y_radius_c] = ...
        get_complementary_ellipses(params, 'FTOC', ErrorType, Subgraph);
    num_points = length(angle_f);
    
    % Ellipse plots
    for point = 1:num_points
        subplot(2,2,1)
        ellipse(x_radius_f(point), y_radius_f(point), -angle_f(point), ...
                x_cent_f(point),   y_cent_f(point)  , 'k');
        hold on
        subplot(2,2,2)
        ellipse(x_radius_c(point), y_radius_c(point), -angle_c(point), ...
                x_cent_c(point),   y_cent_c(point), 'k');
        hold on
    end

    % Set axis properties for FTOC Field ellipse plot
    subplot(2,2,1)
    if (strcmp(AxisStyle, 'crosshairs'))
        draw_crosshairs(params.field);
        axis off
        draw_scalebar(params.field)
    else
        set(gca, 'FontSize', 16)
    end
    set_axis_props(params.field)
    title(params.field.title);
    xlabel(params.field.xlabel);
    ylabel(params.field.ylabel);
   
    % Set axis properties for FTOC colliculus ellipse plot
    subplot(2,2,2)
    if (strcmp(AxisStyle, 'crosshairs'))
        axis off
        draw_scalebar(params.coll)
    else
        set(gca, 'FontSize', 16)
    end
    set_axis_props(params.coll)
    title(params.coll.title);
    xlabel(params.coll.xlabel);
    ylabel(params.coll.ylabel);
      
    %CTOF
    
    [x_cent_c, y_cent_c, angle_c, x_radius_c, y_radius_c, ...
     x_cent_f, y_cent_f, angle_f, x_radius_f, y_radius_f] = ...
        get_complementary_ellipses(params, 'CTOF', ErrorType, Subgraph);
    num_points = length(angle_c);
    
    % Ellipse plots
    for point = 1:num_points
        subplot(2,2,3)
        ellipse(x_radius_f(point), y_radius_f(point), -angle_f(point), ...
                x_cent_f(point),   y_cent_f(point), 'b');
        hold on
        subplot(2,2,4)
        ellipse(x_radius_c(point), y_radius_c(point), -angle_c(point), ...
                x_cent_c(point),   y_cent_c(point), 'b');
        hold on
    end

    % Set axis properties for CTOF field ellipse plot
    subplot(2,2,3)
    if (strcmp(AxisStyle, 'crosshairs'))
        draw_crosshairs(params.field)
        axis off
        draw_scalebar(params.field)
    else
        set(gca, 'FontSize', 16)
    end
    set_axis_props(params.field)
    xlabel(params.field.xlabel);
    ylabel(params.field.ylabel);
    
    % Set axis properties for CTOF colliculus ellipse plot
    subplot(2,2,4)
    if (strcmp(AxisStyle, 'crosshairs'))
        axis off
        draw_scalebar(params.coll)
    else
        set(gca, 'FontSize', 16)
    end
    set_axis_props(params.coll)
    xlabel(params.coll.xlabel);
    ylabel(params.coll.ylabel);

    filename = [num2str(params.id),'_fig5.pdf'];
    print(5,'-dpdf',filename)
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
