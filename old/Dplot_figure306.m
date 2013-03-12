function params = Dplot_figure306(params, plotting)
%D based on plot_figure3.m
%D the object is to plot out the full fields and
%D then only those fields associated with the subgraph
%D to mirror Figure 6 

    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;

    pos = params.FTOC.points_in_subgraph;
    
    figure(306)
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
        %D computing standard errors of mean   NO

        x_radius_cc(point) = x_radius_c;
        y_radius_cc(point) = y_radius_c;

        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        coll_centred_points = [coll_centred_points; centred_points];

            subplot(2,2,1)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
	    hold on
            subplot(2,2,2)
            ellipse(x_radius_cc(point),y_radius_cc(point),-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
	    hold on

        end
    
   subplot(2,2,1)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)

   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis([-50 50 -50 50]);

   axis off
 %      axis ij
%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,%'YTickLabel',{'-50','0','50'})
%        axis([-50 50 -50 50]);
        title(['#',num2str(params.id),'. FTOC; Field']);


        subplot(2,2,2)

%        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis off
   title(['Colliculus']);



%D  Now plot out fields only for the points in the largest ordered subgraph
	
    num_points = length(pos);
				   
    for point = 1:num_points
        centre = params.FTOC.field_points(pos(point),:);
        [from_points,projection_points] = find_projection(centre,radius,full_field_coords,full_coll_coords);
        num_projection = length(projection_points);
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(from_points);
        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(projection_points);

        x_radius_cc(point) = x_radius_c;
        y_radius_cc(point) = y_radius_c;

        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        coll_centred_points = [coll_centred_points; centred_points];

        subplot(2,2,3)
        ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
        hold on
        subplot(2,2,4)
        ellipse(x_radius_cc(point),y_radius_cc(point),-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
	hold on

    end
    
    
    [angle_c1,x_radius_c1,y_radius_c] = plot_error_ellipse(coll_centred_points);
    params.stats.FTOC.subgraph_dispersion_angle = -angle_c;
    params.stats.FTOC.subgraph_dispersion_xrad = mean(x_radius_cc);
    params.stats.FTOC.subgraph_dispersion_yrad = mean(y_radius_cc);
    

   subplot(2,2,3)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis([-50 50 -50 50]);
   axis off
   hold off


%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
 %       axis([-50 50 -50 50]);

   
   subplot(2,2,4)

   hold off
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1])
   axis off
   axis ij
%        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})

    
    
    figure(306)
    orient tall
    filename = [num2str(params.id),'_fig306.pdf'];
    print(306,'-dpdf',filename)
    
