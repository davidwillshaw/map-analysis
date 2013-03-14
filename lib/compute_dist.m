function D = compute_dist(P) 
% Number of vectors
    Q = size(P, 2);
    
    % X and Y components
    XA = repmat(P(1,:), Q, 1);
    XB = repmat(transpose(P(1,:)), 1, Q);
    YA = repmat(P(2,:), Q, 1);
    YB = repmat(transpose(P(2,:)), 1, Q);
    
    % Find distances
    D = sqrt((XA - XB).^2 + (YA - YB).^2);
end
