function params = plot_figure3(params, plotting)


    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    
    if plotting ==1
        figure(3)
        clf
    end
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
        if plotting ==1
            subplot(2,3,1)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
            subplot(2,3,2)
            ellipse(x_radius_c,y_radius_c,-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
        end
    end
    
    
    [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(coll_centred_points);
    params.stats.FTOC.dispersion_angle = angle_c;
    params.stats.FTOC.dispersion_xrad = x_radius_c;
    params.stats.FTOC.dispersion_yrad = y_radius_c;
    
    if plotting == 1
        subplot(2,3,1)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
        axis([-50 50 -50 50]);
        title('Field');
   
        subplot(2,3,2)
        axis ij
        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
        title('Colliculus');
    
        subplot(2,3,3)
        N = hist3(coll_centred_points,'edges', {(-56.5:1:56.5)', (-56.5:1:56.5)'});
        imagesc(N')
        hold on
        [~,x_ell,y_ell] = ellipse(x_radius_c,y_radius_c,-angle_c,mean(coll_centred_points(:,1))+57,mean(coll_centred_points(:,2))+57);
        plot(x_ell,y_ell,'w','LineWidth', 2)
        
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,57,113] , 'XTickLabel', {'-0.5','0','0.5'}, 'YTick',[1,57,113],'YTickLabel', {'-0.5','0','0.5'} )
        axis([1,113,1,113])
    end
    
    
    
    
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
        if plotting == 1
            subplot(2,3,4)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(projection_points(:,1)),mean(projection_points(:,2)),'b');
            subplot(2,3,5)
            ellipse(x_radius_c,y_radius_c,-angle_c,mean(from_points(:,1)),mean(from_points(:,2)),'b');
        end
    end
    
    [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(field_centred_points);
    params.stats.CTOF.dispersion_angle = angle_f;
    params.stats.CTOF.dispersion_xrad = x_radius_f;
    params.stats.CTOF.dispersion_yrad = y_radius_f;
    
    if plotting == 1
        subplot(2,3,4)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'})
        axis([-50 50 -50 50]);
   
        subplot(2,3,5)
        axis ij
        axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
   
    
        subplot(2,3,6)
        N = hist3(field_centred_points,'edges', {(-20.5:1:20.5)', (-20.5:1:20.5)'});
        imagesc(N')
    %plot(field_centred_points(:,1),field_centred_points(:,2),'x','Color',[0.8,0.8,0.8])
        hold on
        [~,x_ell,y_ell] = ellipse(x_radius_f,y_radius_f,-angle_f,mean(field_centred_points(:,1))+21,mean(field_centred_points(:,2))+21);
        plot(x_ell,y_ell,'w','LineWidth',2)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,21,41] ,'XTickLabel',{'-20','0','20'}, 'YTick',[1,21,41],'YTickLabel',{'-20','0','20'} )
        axis([1,41,1,41])
    end
    
    
    figure(3)
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
    