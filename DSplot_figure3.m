function params = DSplot_figure3(params)

    xmean_coll = 0.5;
    ymean_coll = 0.5;
    
    figure(3)
    clf

    %RTOC

    
    num_points = params.RTOC.numpoints;
    full_ret_coords = params.full_ret;
    full_coll_coords = params.full_coll;
    radius = params.ret_radius;
    ret_centred_points = [];
    coll_centred_points = [];

    for point = 1:num_points
        centre = params.RTOC.ret_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_ret_coords,full_coll_coords);
        num_projection = length(projection_points);
%       plot_error_ellipse determines parameters of ellipse to be drawn
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(from_points);
        [angle_c,x_radius_c,y_radius_c] =plot_error_ellipse(projection_points);

        %D computing standard errors of mean  NO
        x_radius_cc(point) = x_radius_c;
        y_radius_cc(point) = y_radius_c;

        centred_points = projection_points-repmat(mean(projection_points),num_projection,1);

        coll_centred_points = [coll_centred_points; centred_points];
	
            subplot(2,3,1)
            ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
            subplot(2,3,2)
            ellipse(x_radius_cc(point),y_radius_cc(point),-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');

    end

%             use plot_error_ellipse to calculate overall angle    
   [angle_c,x_radius_c1,y_radius_c1] = plot_error_ellipse(coll_centred_points);

    params.stats.RTOC.overall_dispersion_angle = -angle_c;
    params.stats.RTOC.overall_dispersion_xrad = x_radius_c1;
    params.stats.RTOC.overall_dispersion_yrad = y_radius_c1;


    params.stats.RTOC.dispersion_xrad = mean(x_radius_cc);
    params.stats.RTOC.dispersion_yrad = mean(y_radius_cc);


        subplot(2,3,1)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
       axis([0 1 0 1]);
        title('Retina');
    xlabel('Temporal-Nasal');
    ylabel('Ventral-Dorsal');
   
        subplot(2,3,2)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
       axis([0 1 0 1]);

        title('Colliculus'); 
   xlabel('Anterior-Posterior');
   ylabel('Medial-Lateral');
%        subplot(2,3,3)
%        N = hist3(coll_centred_points,'edges', {(-56.5:1:56.5)', (-56.5:1:56.5)'});
%        imagesc(N')
%        hold on
%        [~,x_ell,y_ell] = ellipse(x_radius_c1,y_radius_c1,-angle_c,mean(coll_centred_points(:,1))+57,mean(coll_centred_points(:,2))+57);
%        plot(x_ell,y_ell,'w','LineWidth', 2)
        
%        axis ij
%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,57,113] , 'XTickLabel', {'-0.5','0','0.5'}, 'YTick',[1,57,113],'YTickLabel', {'-0.5','0','0.5'} )
%        axis([1,113,1,113])

      
    %CTOR
    
    num_points = params.CTOR.numpoints;
    radius = params.coll_radius;

    for point = 1:num_points
        centre = params.CTOR.coll_points(point,:);
        [from_points,projection_points] = find_projection(centre,radius,full_coll_coords,full_ret_coords);
        num_projection = length(projection_points);

        [angle_c,x_radius_c,y_radius_c] = plot_error_ellipse(from_points);
        [angle_f,x_radius_f,y_radius_f] = plot_error_ellipse(projection_points);
        x_radius_ff(point) =x_radius_f;
        y_radius_ff(point) = y_radius_f;


        centred_points = projection_points - repmat(mean(projection_points),num_projection,1);
        ret_centred_points = [ret_centred_points; centred_points];
        subplot(2,3,4)
        ellipse(x_radius_ff(point),y_radius_ff(point),-angle_f,mean(projection_points(:,1)),mean(projection_points(:,2)),'b');
        subplot(2,3,5)
        ellipse(x_radius_c,y_radius_c,-angle_c,mean(from_points(:,1)),mean(from_points(:,2)),'b');
     end
    
%                   overall dispersion
    [angle_f,x_radius_f1,y_radius_f1] = plot_error_ellipse(ret_centred_points);

    params.stats.CTOR.overall_dispersion_xrad = x_radius_f1;
    params.stats.CTOR.overall_dispersion_yrad = y_radius_f1;
    params.stats.CTOR.overall_dispersion_angle =-angle_f;


    params.stats.CTOR.dispersion_xrad = mean(x_radius_ff);
    params.stats.CTOR.dispersion_yrad = mean(y_radius_ff);


        subplot(2,3,4)

        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
        axis([0 1 0 1]);
    xlabel('Temporal-Nasal');
    ylabel('Ventral-Dorsal');
          
        subplot(2,3,5)
        axis ij
        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[0,0.5,1] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[0,0.5,1] ,'YTickLabel',{'0','0.5','1'})
        axis([0 1 0 1]);

   xlabel('Anterior-Posterior');
   ylabel('Medial-Lateral');


%        subplot(2,3,6)
%        N = hist3(ret_centred_points,'edges', {(-20.5:1:20.5)', (-20.5:1:20.5)'});
%        imagesc(N')
    %plot(ret_centred_points(:,1),ret_centred_points(:,2),'x','Color',[0.8,0.8,0.8])
%        hold on
%        [~,x_ell,y_ell] = ellipse(x_radius_f1,y_radius_f1,-angle_f,mean(ret_centred_points(:,1))+21,mean(ret_centred_points(:,2))+21);
%        plot(x_ell,y_ell,'w','LineWidth',2)
%        axis ij
%        set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[1,21,41] ,'XTickLabel',{'-20','0','20'}, 'YTick',[1,21,41],'YTickLabel',{'-20','0','20'} )
%        axis([1,41,1,41])
    
    
    figure(3)
    orient tall
    filename = [num2str(params.id),'_fig3.pdf'];
    print(3,'-dpdf',filename)
    
