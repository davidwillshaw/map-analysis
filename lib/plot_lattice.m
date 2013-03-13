function h = plot_lattice(params, direction, h1, h2, varargin)
% PLOT_LATTICE - Lattice and complementary distribution plotting function
%   
%   Plot the lattice and/or complementary distributions of PARAMS in
%   DIRECTION into subplots with handles H1 and H2.
%   
%   For the FTOC direction, the distribution of pixels on the
%   colliculus associated with the points within each small circular
%   area of field of radius params.field_radius is the called the
%   complementary distribution. Using the 'ErrorType' argument, this
%   function plots the complementary distributions for each node in
%   the lattice in the FTOC and CTOF directions.
%
%   The function accepts a number of options, specified as
%   name-argument pairs:
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
%   - EctOptions: (for FTOC ONLY)
%       (i) ectopics marked in the subgraph plot in blue crosses
%       (ii) options shown by value of ectoptions:
%       EctOptions = 0: raw subgraph
%       EctPptions = 1: as (0) but mean positions of ectopics shown in blue
%       EctOptions = 2: as (1) and major and minor extents of
%       ectopics also shown 
%       EctOptions = 3: as (1) and extents of ectopics shown by a line only
%       EctOptions = 4: (2) and (3) combined - major and minor plus
%       line
%    
%   - AncLabels: If provided, specifies numbered points for anchors.
%
%   - AncSize: Size of anchors.
%    
%   - LatticeColour: Colour of lattice. Defaults to black for
%       'FTOC' direction and blue for 'CTOF' direction
%     
%   - Lattice: If true (default), print a Lattice.
%
%   - PointNumbers: If true (default false), print ids of points at
%       their respective locations.
%    
% See also: plot_angles, plot_superposed

if (nargin > 4) 
    p = validateInput(varargin, {'ErrorType', 'AxisStyle', 'Subgraph', ...
                        'AncLabels', 'AncSize', 'LatticeColour', ...
                        'EctOptions', 'Lattice', 'PointNumbers'});
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
    Subgraph = p.Subgraph;
end

ancnums = params.anchors;
anclabels = [];
if (isfield(p, 'AncLabels'))
    anclabels = p.AncLabels;
    ancnums=length(anclabels);
end

ancsize = 6;
if isfield(p, 'AncSize')
    ancsize = p.AncSize;
end

Lattice = true;
if isfield(p, 'Lattice')
    Lattice = p.Lattice;
end

if strcmp(direction,'CTOF')
    LatticeColour = 'b';
else
    LatticeColour = 'k';
end
if isfield(p, 'LatticeColour')
    LatticeColour = p.LatticeColour;
end

ectoptions = 0;
if isfield(p, 'EctOptions')
    ectoptions = p.EctOptions;
end

PointNumbers = false;
if isfield(p, 'PointNumbers')
    PointNumbers = p.PointNumbers;
end

% Clear axes
subplot(h1)
cla
subplot(h2)
cla

% Plots out the numbers of each node so that anchors can be chosen
% easily.
if (PointNumbers)
    if (strcmp(direction, 'FTOC'))
        num_points = params.FTOC.numpoints;
        takeout = params.FTOC.takeout;
        from_coords = params.FTOC.field_points;
        to_coords = params.FTOC.coll_points;

    else
        num_points = params.CTOF.numpoints;
        takeout = params.CTOF.takeout;
        from_coords = params.CTOF.field_points;
        to_coords = params.CTOF.coll_points;
    end
    list_of_points = setdiff(1:num_points,takeout);
    subplot(h1)
    for lop=1:length(list_of_points)
      text(from_coords(lop,1), from_coords(lop,2), ...
           num2str(list_of_points(lop)),'FontSize',6);
    end
    subplot(h2)
    for lop=1:length(list_of_points)
      text(to_coords(lop,1), to_coords(lop,2), ...
           num2str(list_of_points(lop)),'FontSize',6);
    end
end

% Plot Ellipses
if (~strcmp(ErrorType, 'none'))
    % Get the ellipses
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
                x_cent_f(point),   y_cent_f(point),   LatticeColour);
        hold on
        subplot(h2)
        ellipse(x_radius_c(point), y_radius_c(point), -angle_c(point), ...
                x_cent_c(point),   y_cent_c(point),   LatticeColour);
        hold on
    end
end

% Plot lattice
if (Lattice) 
    if strcmp(direction,'CTOF')
        coll_coords = params.CTOF.coll_points;
        field_coords = params.CTOF.field_points;
        points_in_subgraph = params.CTOF.points_in_subgraph;
        list_of_neighbours = params.CTOF.list_of_neighbours;
        num_points = params.CTOF.numpoints;
        sets_of_intersections = params.CTOF.sets_of_intersections;
        points_not_in_subgraph = params.CTOF.points_not_in_subgraph;
    end

    if strcmp(direction,'FTOC')
        %D      inserted details of the ectopics
        ectopics=params.FTOC.stats.ectopics;
        major_projection = params.FTOC.major_projection;
        minor_projection = params.FTOC.minor_projection;
        mean_projection = params.FTOC.mean_projection;

        coll_coords = params.FTOC.coll_points;
        field_coords = params.FTOC.field_points;
        points_in_subgraph = params.FTOC.points_in_subgraph;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        num_points = params.FTOC.numpoints;
        sets_of_intersections = params.FTOC.sets_of_intersections;
        points_not_in_subgraph = params.FTOC.points_not_in_subgraph;
    end

    % Lattice on Field
    subplot(h1)
    % Full graph
    if (~Subgraph)
        print_links(1:num_points, field_coords, list_of_neighbours, LatticeColour);
        hold on
        [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
        print_links(cross_points, field_coords, list_of_crossings, 'r');
    else
        % Subgraph only
        print_links(points_in_subgraph, field_coords, list_of_neighbours, LatticeColour);
        hold on
        %   plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'or','MarkerFaceColor', 'r', 'MarkerSize',1);
        if ectoptions == 0
            plot(field_coords(points_not_in_subgraph,1),field_coords(points_not_in_subgraph,2),'xr');
        end
        [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
        print_links(cross_points, field_coords, list_of_crossings, 'r');
    end
    anchors = plot_anchors(field_coords,ancnums,anclabels,ancsize);

    if strcmp(direction,'FTOC')
        if ectoptions ==1 |ectoptions ==2 |ectoptions ==3 | ectoptions ==4
            sd = setdiff(points_not_in_subgraph,ectopics);
            plot(field_coords(sd,1),field_coords(sd,2),'xr');
            plot(field_coords(ectopics,1),field_coords(ectopics,2),'o','Color',[0 0 1]);
        end
    end

    % Lattice on Colliculus
    subplot(h2)
    if (~Subgraph)
        print_links(1:num_points, coll_coords, list_of_neighbours, LatticeColour);
        hold on
        [cross_points,list_of_crossings] = make_cross_list(1:num_points,sets_of_intersections);
        print_links(cross_points, coll_coords, list_of_crossings, 'r');
    else   
        print_links(points_in_subgraph, coll_coords, list_of_neighbours, LatticeColour);
        hold on
        if strcmp(direction,'FTOC')
            %   plot(coll_coords(setdiff(points_not_in_subgraph,ectopics),1),coll_coords(setdiff(points_not_in_subgraph,ectopics),2),'or','MarkerFaceColor', 'r')
            plot(coll_coords(setdiff(points_not_in_subgraph,ectopics),1),  ...
                 coll_coords(setdiff(points_not_in_subgraph,ectopics),2),'xr');

            if ectoptions ==1 |ectoptions == 2 |ectoptions == 3 | ectoptions ==4
                plot(coll_coords(ectopics,1),coll_coords(ectopics,2),'ob');
            end

            if ectoptions == 2 | ectoptions ==4
                for i = 1:size(major_projection)
                    if ismember(i,ectopics)
                        plot(major_projection(i,1),major_projection(i,2),'bo','MarkerSize',6,'MarkerFaceColor','b');
                        hold on
                        plot(minor_projection(i,1),minor_projection(i,2),'bo', 'MarkerSize',3,'MarkerFaceColor','b');
                    end
                end
            end

            if ectoptions==3 | ectoptions ==4   
                %line([minor_projection(ectopics,1)';major_projection(ectopics,1)'],[minor_projection(ectopics,2)';major_projection(ectopics,2)'],'Color','b','LineWidth',1);
                line([minor_projection(ectopics,1)';major_projection(ectopics,1)'],[minor_projection(ectopics,2)'; major_projection(ectopics,2)'],'Color','b','LineWidth',0.5);
            end
            %D-----------------------------------------------------------------------------------------------------------------------------------------------------
        end
        [cross_points,list_of_crossings] = make_cross_list(points_in_subgraph,sets_of_intersections);
        print_links(cross_points, coll_coords, list_of_crossings, 'r');
    end 
    plot_anchors(coll_coords,ancnums,anclabels,ancsize);
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
