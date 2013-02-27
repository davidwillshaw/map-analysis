function h = plot_figure3(params, varargin)
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
% See also plot_figure5, find_overall_dispersion, get_centred_points
    
    if (nargin >= 2) 
        p = validateInput(varargin, {'ErrorType', 'AxisStyle'});
    else
        p = struct();
    end
    AxisStyle = 'crosshairs'; % Other option is 'box'
    if (isfield(p, 'AxisStyle'))
        AxisStyle = p.AxisStyle;
    end

    h = figure(3);
    clf

    %FTOC
    coll_centred_points = get_centred_points(params, 'FTOC');

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
    [~,x_ell,y_ell] = ellipse(params.stats.FTOC.overall_dispersion_xrad, ...
                              params.stats.FTOC.overall_dispersion_yrad, ...
                              params.stats.FTOC.overall_dispersion_angle, ...
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

    if (strcmp(AxisStyle, 'box'))
        set(gca, 'FontSize', 16)
    else %AxisStyle == 'crosshairs')
        draw_scalebar(params.coll, 'scale', params.coll.scale*bs, ...
                      'XLim', lim, 'YLim', lim, ...
                      'colour', 'w')
        axis off
    end
      
    %CTOF
    field_centred_points = get_centred_points(params, 'CTOF');

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
    [~,x_ell,y_ell] = ellipse(params.stats.CTOF.overall_dispersion_xrad, ...
                              params.stats.CTOF.overall_dispersion_yrad, ...
                              params.stats.CTOF.overall_dispersion_angle, ...
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

    if (strcmp(AxisStyle, 'box'))
        set(gca, 'FontSize', 16)
    else %AxisStyle == 'crosshairs')
        draw_scalebar(params.field, 'scale', params.field.scale*bs, ...
                      'XLim', lim, 'YLim', lim, ...
                      'colour', 'w')
        axis off
    end
    
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
end

% Local Variables:
% matlab-indent-level: 4
% End:
