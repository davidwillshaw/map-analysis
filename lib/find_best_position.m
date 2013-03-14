function [major_projection_posn minor_projection_posn, optimal_position] = find_best_position(field_points,major_projection, minor_projection, takeout )

%D  OPTIMAL position C on colliculus for field position F found
%D  by interpolating between positions C1,C2,C3 of the three positions F1,F2,F3
%D  that surround F
%D   the MAJOR position is defined as that of the two points that 
%D  is nearer to the OPTIMAL position.
%D  the MINOR is the other point

    ectopics  = find(minor_projection(:,1)~= 0);
    total_ectopics = length(ectopics);
    total_field_points = 1:length(field_points);
    included_field_points = setdiff(total_field_points,ectopics);
    included_field_points = setdiff(included_field_points,takeout);
    triangles = delaunay(field_points(included_field_points,1),field_points(included_field_points,2));
    [t,P] = tsearchn(field_points(included_field_points,:),triangles,field_points(ectopics,:));
    optimal_position = zeros(total_ectopics,2);
    for ect = 1:total_ectopics
        if isnan(t(ect))
            disp('fail')
            continue
        end
        enclosing_triangle = triangles(t(ect),:);
        points_in_triangle = included_field_points(enclosing_triangle);
        triangle_coords = field_points(points_in_triangle,:);
        optimal_position(ect,:) =P(ect,:)*triangle_coords;
    end
    
    major_projection_posn = major_projection;
    minor_projection_posn = minor_projection;
    for ect = 1:total_ectopics
        if isnan(t(ect))
            continue
        end
        if (compute_dist(major_projection(ectopics(ect),:),optimal_position(ect,:)') > ...
            compute_dist(minor_projection(ectopics(ect),:),optimal_position(ect,:)'))
            major_projection_posn(ectopics(ect),:) = minor_projection(ectopics(ect),:);
            minor_projection_posn(ectopics(ect),:) = major_projection(ectopics(ect),:);
        end
    end
    
    
    