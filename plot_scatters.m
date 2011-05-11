function [] = plot_scatters(params)

    figure(1)
    
    %FTOC field
    subplot(2,2,1)
    num_points = params.FTOC.numpoints;
    from_coords = params.full_field;
    to_coords = params.full_coll;
    radius = params.field_radius;
    for point = 1:numpoints
        centre = params.FTOC.field_points(point,:);
        projection_points = find_projection(centre,radius,from_coords,to_coords);
        