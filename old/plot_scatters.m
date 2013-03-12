function [] = plot_scatters(params)

    figure(1)
    
    %FTOC
    
    num_points = params.FTOC.numpoints;
    full_field_coords = params.full_field;
    full_coll_coords = params.full_coll;
    radius = params.field_radius;

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
        subplot(2,2,1)
        ellipse(x_radius_f,y_radius_f,-angle_f,mean(from_points(:,1)),mean(from_points(:,2)),'k');
        subplot(2,2,2)
        ellipse(x_radius_c,y_radius_c,-angle_c,mean(projection_points(:,1)),mean(projection_points(:,2)),'k');
    end
    
    subplot(2,2,1)
    set(gca,'PlotBoxAspectRatio',[1,1,1])
    axis ij
    subplot(2,2,2)
    set(gca,'PlotBoxAspectRatio',[1,1,1])
    axis ij
    
    
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
        subplot(2,2,3)
        ellipse(x_radius_f,y_radius_f,-angle_f,mean(projection_points(:,1)),mean(projection_points(:,2)),'b');
        subplot(2,2,4)
        ellipse(x_radius_c,y_radius_c,-angle_c,mean(from_points(:,1)),mean(from_points(:,2)),'b');
    end
    
    subplot(2,2,3)
    set(gca,'PlotBoxAspectRatio',[1,1,1])
    axis ij
    subplot(2,2,4)
    set(gca,'PlotBoxAspectRatio',[1,1,1])
    axis ij