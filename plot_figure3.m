function params = plot_figure3(params, axis_style)
% PLOT_FIGURE3 - Plot superposed distributions
%       
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution.
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
%   This function plots the superposed distribution all nodes in the
%   lattice in the FTOC and CTOF directions.
%   
%   The following properties control what is plotted and the
%   appearance of the plot:
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
%   - Properties of the superposed distribution (also referred to as
%     "overall complementary distribution"; see Table 5 in Willshaw et
%     al., 2013):
%
%     params.stats.FTOC.overall_dispersion_xrad - Length of major axis
%       ellipse fitted to superposed distribution
%
%     params.stats.FTOC.overall_dispersion_yrad - Length of minor axis
%       ellipse fitted to superposed distribution
%
%     params.stats.FTOC.overall_dispersion_angle - Angle of major axis
%       of ellipse. The zero degree line is defined on the colliculus
%       as rostral to caudal and in the visual field as temporal to
%       nasal. Clockwise rotations are positive.
% 
% See also plot_figure5
    
    if (~exist('axis_style'))     
        axis_style = 'crosshairs'; % Other option is 'box'
    end

    figure(3)
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
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);

        coll_centred_points = [coll_centred_points; centred_points];
    end

    % use plot_error_ellipse to calculate overall angle, i.e. the
    % angle of the superposed distribution
    [angle_c, x_radius_c, y_radius_c] = plot_error_ellipse(coll_centred_points);

    params.stats.FTOC.overall_dispersion_angle = -angle_c;
    params.stats.FTOC.overall_dispersion_xrad = x_radius_c;
    params.stats.FTOC.overall_dispersion_yrad = y_radius_c;

    % Superposed distribution on colliculus
    subplot(2,1,1)
    
    % Plot the histogram
    bs = params.coll.SuperposedHistBinSize;
    histlim = params.coll.SuperposedHistLim;
    edges = ((-histlim - bs/2):bs:(histlim + bs/2))';
    lim = [1, length(edges) - 1];
    tick = [lim(1), length(edges)/2, lim(2)];
    ticklabel = ({num2str(-histlim*params.coll.scale), '0', ...
                  num2str(histlim*params.coll.scale)});
    N = hist3(coll_centred_points,'edges', {edges, edges});
    imagesc(N')
    hold on
    
    % Draw ellipse round histogram
    [~,x_ell,y_ell] = ellipse(x_radius_c, y_radius_c, -angle_c, ...
                              mean(coll_centred_points(:,1)) + tick(2), ...
                              mean(coll_centred_points(:,2)) + tick(2));
    plot(x_ell,y_ell,'w','LineWidth', 2)

    % Set axis properties
    set_axis_props(params.coll)
    axis([1, tick(3), 1, tick(3)])
    set(gca, 'XTick', tick, ...
             'YTick', tick, ...
             'XTickLabel', ticklabel, ...
             'YTickLabel', ticklabel)

    if (strcmp(axis_style, 'box'))
        set(gca, 'FontSize', 16)
    else %axis_style == 'crosshairs')
        draw_scalebar(params.coll, 'scale', params.coll.scale*bs, ...
                      'XLim', lim, 'YLim', lim, ...
                      'colour', 'w')
        axis off
    end
      
    %CTOF
    
    num_points = params.CTOF.numpoints;
    radius = params.coll_radius

    % Ellipse plots
    for point = 1:num_points
        centre = params.CTOF.coll_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_coll_coords,full_field_coords);
        num_projection = length(projection_points);
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        field_centred_points = [field_centred_points; centred_points];
    end
    
    % use plot_error_ellipse to calculate characteristics of the
    % superposed distribution
    [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(field_centred_points);

    params.stats.CTOF.overall_dispersion_xrad = x_radius_f;
    params.stats.CTOF.overall_dispersion_yrad = y_radius_f;
    params.stats.CTOF.overall_dispersion_angle =-angle_f;

    % Superposed distribution on field
    subplot(2,1,2)
    
    % Plot the histogram
    bs = params.field.SuperposedHistBinSize;
    histlim = params.field.SuperposedHistLim;
    edges = ((-histlim - bs/2):bs:(histlim + bs/2))';
    lim = [1, length(edges)-1];
    tick = [lim(1), length(edges)/2, lim(2)];
    ticklabel = ({num2str(-histlim*params.field.scale), '0', ...
                  num2str(histlim*params.field.scale)});

    N = hist3(field_centred_points,'edges', {edges, edges});
    imagesc(N')
    hold on
    
    % Draw ellipse round histogram
    [~,x_ell,y_ell] = ellipse(x_radius_f, y_radius_f, -angle_f, ...
                              mean(field_centred_points(:,1)) + tick(2), ...
                              mean(field_centred_points(:,2)) + tick(2));
    plot(x_ell,y_ell, 'w', 'LineWidth', 2)

    % Set axis properties
    set_axis_props(params.field)
    axis([1, tick(3), 1, tick(3)])
    set(gca, 'XTick', tick, ...
             'YTick', tick, ...
             'XTickLabel', ticklabel, ...
             'YTickLabel', ticklabel)

    if (strcmp(axis_style, 'box'))
        set(gca, 'FontSize', 16)
    else %axis_style == 'crosshairs')
        draw_scalebar(params.field, 'scale', params.field.scale*bs, ...
                      'XLim', lim, 'YLim', lim, ...
                      'colour', 'w')
        axis off
    end
    
    figure(3)
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
end

% Local Variables:
% matlab-indent-level: 4
% End:
