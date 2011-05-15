function params = find_ectopics(params)

    
    FRAC_SPREAD = 0.5;
    numpoints = params.FTOC.numpoints;
    field_points = params.FTOC.field_points;
    full_field_coords = params.full_field;
    full_coll_coords = params.full_coll;
    takeout = params.FTOC.takeout;
    radius = params.field_radius;
    major_projection = params.FTOC.coll_points;
    minor_projection = zeros(numpoints,2);
    
    for point = 1:numpoints
        centre = field_points(point,:);
        [~,projection_points] = find_projection(centre,radius,full_field_coords,full_coll_coords);
        [IDX1, C1, SUMD1] = kmeans(projection_points,1);
        [IDX2, C2, SUMD2] = kmeans(projection_points,2, 'replicates',5);
        I1=find(IDX2==1);
        I2=find(IDX2==2);
        mean_single = mean(projection_points);
        sd_single = sqrt(sum(std(projection_points).^2));
        mean_1 = mean(projection_points(I1,:));
        sd_1 = sqrt(sum(std(projection_points(I1,:)).^2));
        mean_2 = mean(projection_points(I2,:));
        sd_2 = sqrt(sum(std(projection_points(I2,:)).^2));
        if length(I1)>4 && length(I2)>4 && ...
                sd_1+sd_2 < FRAC_SPREAD*dist(C2(1,:),C2(2,:)')
            
            if length(I1)>=length(I2)
                major_projection(point,:) = C2(1,:);
                minor_projection(point,:) = C2(2,:);
            else
                major_projection(point,:) = C2(2,:);
                minor_projection(point,:) = C2(1,:);
            end
        end
    end
    
    [major_projection minor_projection, optimal_position] = find_best_position(field_points,major_projection, minor_projection, takeout );
    
    params.FTOC.major_projection = major_projection;
    params.FTOC.minor_projection = minor_projection;
    params.FTOC.optimal_position = optimal_position;
    
            
            
       
    