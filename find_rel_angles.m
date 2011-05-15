function angles = find_rel_angles(list_of_neighbours,from_points,to_points)

    point_1 = from_points(list_of_neighbours(:,1),:);
    point_2 = from_points(list_of_neighbours(:,2),:);
    vec_1 = point_1 - point_2;
    
    point_1 = to_points(list_of_neighbours(:,1),:);
    point_2 = to_points(list_of_neighbours(:,2),:);
    vec_2 = point_1 - point_2;
    dot_products = diag(vec_1*vec_2');
    length_product = sqrt(sum(vec_1.^2,2)).*sqrt(sum(vec_2.^2,2));
    cosine_theta = dot_products./length_product;
    angles = acos(cosine_theta);
    
    


    

    