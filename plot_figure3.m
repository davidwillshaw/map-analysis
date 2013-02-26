function params = plot_figure3(params, ErrorType, axis_style)
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

    xmean_coll = params.coll.xmean;
    ymean_coll = params.coll.ymean;
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
    [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(coll_centred_points);

    params.stats.FTOC.overall_dispersion_angle = -angle_c;
    params.stats.FTOC.overall_dispersion_xrad = x_radius_c;
    params.stats.FTOC.overall_dispersion_yrad = y_radius_c;

    subplot(2,1,1)
    N = hist3(coll_centred_points,'edges', {(-56.5:1:56.5)', (-56.5:1:56.5)'});
    imagesc(N')
    hold on
    [~,x_ell,y_ell] = ellipse(x_radius_c,y_radius_c,-angle_c,mean(coll_centred_points(:,1))+57,mean(coll_centred_points(:,2))+57);
    plot(x_ell,y_ell,'w','LineWidth', 2)
    axis ij
    axis([1,113,1,113])
    if (strcmp(axis_style, 'box'))
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,57,113] , 'XTickLabel', {'-0.5','0','0.5'}, 'YTick',[1,57,113],'YTickLabel', {'-0.5','0','0.5'} )
    else %axis_style == 'crosshairs')

        plot(4:14,ones(11,1).*110,'w', 'LineWidth',3)%scale bar        
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,57,113] , 'XTickLabel', {'-0.5','0','0.5'}, 'YTick',[1,57,113],'YTickLabel', {'-0.5','0','0.5'} )
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
    
    subplot(2,1,2)
    N = hist3(field_centred_points,'edges', {(-20.5:1:20.5)', (-20.5:1:20.5)'});
    imagesc(N')
    %plot(field_centred_points(:,1),field_centred_points(:,2),'x','Color',[0.8,0.8,0.8])
    hold on
    [~,x_ell,y_ell] = ellipse(x_radius_f,y_radius_f,-angle_f,mean(field_centred_points(:,1))+21,mean(field_centred_points(:,2))+21);
    plot(x_ell,y_ell,'w','LineWidth',2)
    if (strcmp(axis_style, 'crosshairs'))
        plot(3:7,ones(5,1).*38,'w', 'LineWidth',3) %scale bar
        axis off   
    end
    axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,21,41] ,'XTickLabel',{'-20','0','20'}, 'YTick',[1,21,41],'YTickLabel',{'-20','0','20'} )
    axis([1,41,1,41])
  
    
    
    figure(3)
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
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

function draw_scalebar(s)
% Draw scalebar
    xmin = s.XLim(1);
    xmax = s.XLim(2);
    ymin = s.YLim(1);
    ymax = s.YLim(2);
    yfrac = 0.05;
    if s.FlipY
        yfrac = 0.95;
    end
    if (s.scalebar > 0) 
        plot(xmin + 0.05*(xmax - xmin) + ...
             [0 s.scalebar/s.scale], ...
             (ymin + yfrac*(ymax - ymin))*ones(1, 2), ...
             'k', 'LineWidth',3) %scale bar
    end
end

function set_axis_props(s)
% Set axis properties
    set(gca, 'XTick', s.XTick, ...
             'YTick', s.YTick, ...
             'XTickLabel', s.XTickLabel, ...
             'YTickLabel', s.YTickLabel)
    if (s.FlipY)
        axis ij
    else
        axis xy
    end
    set(gca,'PlotBoxAspectRatio',[1 1 1])
    axis([s.XLim s.YLim]);
end

% Local Variables:
% matlab-indent-level: 4
% End:
