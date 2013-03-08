function [scatter_mean, list_of_variance] = find_scatter(list_of_points, from_points, full_from_coords, full_to_coords, radius)
    
    num_points = length(list_of_points);
    list_of_variance = zeros(num_points,2);
    for point = 1:num_points
        active = list_of_points(point);
        centre = from_points(active,:);
        [~,projection_points] = find_projection(centre,radius,full_from_coords,full_to_coords);
        list_of_variance(point,:) = var(projection_points);
    end
    
    scatter_mean = sqrt(sum(mean(list_of_variance)));