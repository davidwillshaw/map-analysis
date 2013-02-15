function params = oct2011_Dplot_figure3(params)


    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    
    figure(3)
    clf

    %FTOC
    
    num_points = params.FTOC.numpoints;
    full_field_coords = params.full_field;
    full_coll_coords = params.full_coll;
    radius = params.field_radius;
    field_centred_points = [];
    coll_centred_points = [];

    for point = 1:num_points
        centre = params.FTOC.field_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_field_coords,full_coll_coords);
        num_projection = length(projection_points);
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(from_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(projection_points);
        x_radius_f = x_radius_f/sqrt(num_projection);
        y_radius_f = y_radius_f/sqrt(num_projection);
        x_radius_c = x_radius_c/sqrt(num_projection);
        y_radius_c = y_radius_c/sqrt(num_projection);
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        coll_centred_points = [coll_centred_points; centred_points];

            subplot(2,2,1)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
            hold on
            subplot(2,2,2)
            ellipse(x_radius_c,y_radius_c,-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
            hold on
    end

    
    
    [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(coll_centred_points);
    params.stats.FTOC.dispersion_angle = angle_c;
    params.stats.FTOC.dispersion_xrad = x_radius_c;
    params.stats.FTOC.dispersion_yrad = y_radius_c;
    
        subplot(2,2,1)
        plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
        hold on
        plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
        plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1])
        axis([-50 50 -50 50]);
        axis off
        title('Field');
   
        subplot(2,2,2)
        plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar
        hold on
        axis ij
        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
        set(gca,'PlotBoxAspectRatio',[1 1 1])
        axis off
        title('Colliculus');
    
    %CTOF
    
    num_points = params.CTOF.numpoints;
    radius = params.coll_radius;

    for point = 1:num_points
        centre = params.CTOF.coll_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_coll_coords,full_field_coords);
        num_projection = length(projection_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(from_points);
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(projection_points);
        x_radius_f = x_radius_f/sqrt(num_projection);
        y_radius_f = y_radius_f/sqrt(num_projection);
        x_radius_c = x_radius_c/sqrt(num_projection);
        y_radius_c = y_radius_c/sqrt(num_projection);
        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        field_centred_points = [field_centred_points; centred_points];

            subplot(2,2,3)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(projection_points(:,1)),mean(projection_points(:,2)),'b');
            hold on
            subplot(2,2,4)
            ellipse(x_radius_c,y_radius_c,-angle_c,mean(from_points(:,1)),mean(from_points(:,2)),'b');
            hold on
    end
    
    [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(field_centred_points);
    params.stats.CTOF.dispersion_angle = angle_f;
    params.stats.CTOF.dispersion_xrad = x_radius_f;
    params.stats.CTOF.dispersion_yrad = y_radius_f;
    
         subplot(2,2,3)
        plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
        hold on
        plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
        axis([-50 50 -50 50]);
        axis off
   
        subplot(2,2,4)
        axis ij
        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
        axis off

    figure(3)
    orient tall
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
    
