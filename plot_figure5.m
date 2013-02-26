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

    if (nargin >= 2) 
        p = validateInput(varargin, {'ErrorType', 'AxisStyle'});
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

    % minor changes from plot_figure3.m
    % mainly moving the plotting option

    xmean_coll = params.coll.xmean;
    ymean_coll = params.coll.ymean;
    figure(5)
    clf

    %FTOC
    
    num_points = params.FTOC.numpoints;
    full_field_coords = params.full_field;
    full_coll_coords = params.full_coll;
    radius = params.field_radius;
    field_centred_points = [];
    coll_centred_points = [];

    % Ellipse plots
    for point = 1:num_points
        centre = params.FTOC.field_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_field_coords,full_coll_coords);
        num_projection = length(projection_points);
        % plot_error_ellipse determines parameters of ellipse to be
        % drawn. x_radius is the length of the major axis and
        % y_radius is the length of the minor axis.
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(from_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(projection_points);
        
        if (strcmp(ErrorType, 'sem'))
            % compute standard errors of mean 
            x_radius_f = x_radius_f/sqrt(num_projection);
            y_radius_f = y_radius_f/sqrt(num_projection);
            x_radius_c = x_radius_c/sqrt(num_projection);
            y_radius_c = y_radius_c/sqrt(num_projection);
        else
            % ErrorType == 'sd'; store standard deviation 
            x_radius_cc(point) = x_radius_c;
            y_radius_cc(point) = y_radius_c;
        end
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);

        coll_centred_points = [coll_centred_points; centred_points];
	

        subplot(2,2,1)
        ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
        hold on
        subplot(2,2,2)
        ellipse(x_radius_c,y_radius_c,-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
        hold on
    end

    % use plot_error_ellipse to calculate overall angle, i.e. the
    % angle of the superposed distribution
    [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(coll_centred_points);

    params.stats.FTOC.overall_dispersion_angle = -angle_c;
    params.stats.FTOC.overall_dispersion_xrad = x_radius_c;
    params.stats.FTOC.overall_dispersion_yrad = y_radius_c;

    if (strcmp(ErrorType, 'sd'))
        params.stats.FTOC.dispersion_xrad = mean(x_radius_cc);
        params.stats.FTOC.dispersion_yrad = mean(y_radius_cc);
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
    
    num_points = params.CTOF.numpoints;
    radius = params.coll_radius;

    % Ellipse plots
    for point = 1:num_points
        centre = params.CTOF.coll_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_coll_coords,full_field_coords);
        num_projection = length(projection_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(from_points);
        [angle_f,x_radius_f,y_radius_f] = ...
            plot_error_ellipse(projection_points);
        if (strcmp(ErrorType, 'sem'))
            % compute standard errors of mean 
            x_radius_f = x_radius_f/sqrt(num_projection);
            y_radius_f = y_radius_f/sqrt(num_projection);
            x_radius_c = x_radius_c/sqrt(num_projection);
            y_radius_c = y_radius_c/sqrt(num_projection);
        else % ErrorType == 'sd'
            x_radius_ff(point) = x_radius_f;
            y_radius_ff(point) = y_radius_f;
        end
      
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        field_centred_points = [field_centred_points; centred_points];

        subplot(2,2,3)
        ellipse(x_radius_f,y_radius_f,-angle_f, ...
                mean(projection_points(:,1)),mean(projection_points(:,2)),'b');
        hold on
        subplot(2,2,4)
        ellipse(x_radius_c,y_radius_c,-angle_c, ...
                mean(from_points(:,1)),mean(from_points(:,2)),'b');
        hold on
    end
    
    % use plot_error_ellipse to calculate characteristics of the
    % superposed distribution
    [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(field_centred_points);

    params.stats.CTOF.overall_dispersion_xrad = x_radius_f;
    params.stats.CTOF.overall_dispersion_yrad = y_radius_f;
    params.stats.CTOF.overall_dispersion_angle =-angle_f;
    
    if (strcmp(ErrorType, 'sd'))
        params.stats.CTOF.dispersion_xrad = mean(x_radius_ff);
        params.stats.CTOF.dispersion_yrad = mean(y_radius_ff);
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
    xmin = min(s.XTick);
    xmax = max(s.XTick);
    ymin = min(s.YTick);
    ymax = max(s.YTick);
    plot([s.xmean s.ymean], ...
         [ymin ymax], ...
         'Color',[0.7 0.7 0.7], 'Linewidth',1)
    hold on
    plot([xmin xmax], ...
         [s.xmean s.ymean],  ...
         'Color',[0.7 0.7 0.7], 'Linewidth',1)
end

% Local Variables:
% matlab-indent-level: 4
% End:
