function [] = plot_indiv_scatters(params)


    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    num_points = params.FTOC.numpoints;
    field_points = params.FTOC.field_points;
    ect = find(params.FTOC.minor_projection(:,1));
    from_coords = params.full_field;
    to_coords = params.full_coll;
    radius = params.field_radius;
    max_scatter = 0;
    min_scatter = 100;
    
    
    for point = 1:num_points
        centre = field_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,from_coords,to_coords);
        scatter = sqrt(sum(var(projection_points)));
        if scatter > max_scatter && ~ismember(point,ect) && rand > 0.8
            max_scatter = scatter;
            max_point_to_plot = point;
            max_points = from_points;
            max_projection = projection_points;
        end
        
        if scatter < min_scatter && ~ismember(point,ect)
            min_scatter = scatter;
            min_point_to_plot = point;
            min_points = from_points;
            min_projection = projection_points;
        end
        
        if point == ect(1)
            ect_points = from_points;
            ect_projection = projection_points;
        end
    end
    
    figure(7)
    clf
    subplot(1,2,1)
    plot(min_points(:,1),min_points(:,2),'x','Color',[0.5,0.5,0.5])
    hold on
    plot(max_points(:,1),max_points(:,2),'xm')
    plot(ect_points(:,1),ect_points(:,2),'xc')
    axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
   axis([-50 50 -50 50]);
    
    
    subplot(1,2,2)
    plot(min_projection(:,1),min_projection(:,2),'x','Color',[0.5,0.5,0.5])
    hold on
    plot(max_projection(:,1),max_projection(:,2),'xm')
    plot(ect_projection(:,1),ect_projection(:,2),'xc')
    ellipse(params.ellipse.ra, params.ellipse.rb, params.ellipse.ang, params.ellipse.x0, params.ellipse.y0,'k')
    axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})

    
    