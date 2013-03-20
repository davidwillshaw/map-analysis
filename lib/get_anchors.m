function [anclabels, anccolours] = get_anchors(points, points_in_subgraph, num_anchors)
    
    % Find locations of field points
    X = points(points_in_subgraph, 1);
    Y = points(points_in_subgraph, 2);

    % Find ideal locations for anchors
    x = [];
    y = [];

    x = min(X) + (max(X) - min(X))*linspace(0, 1, num_anchors);
    y = min(Y) + (max(Y) - min(Y))*0.5*ones(1, num_anchors);
          
    x = [x, min(X) + (max(X) - min(X))*0.5*ones(1, num_anchors)];
    y = [y, min(Y) + (max(Y) - min(Y))*linspace(0, 1, num_anchors)];

    % Remove any non-unique points
    P = [transpose(x) transpose(y)];
    P = unique([transpose(x) transpose(y)], 'rows');
    x = P(:,1);
    y = P(:,2);
    
    % Find closest actual points
    for i = 1:numel(x)
        [~, closest_point] = min((X - x(i)).^2 + (Y - y(i)).^2);
        anclabels(i) = points_in_subgraph(closest_point);
    end
    
    % Compute RGB colours
    
    % Define mapping of location onto RGB colours. Each column
    % represents paramters for R, G, and B
    A = [240  202.5   59 ;
         -54 -127.0   26 ;
         -104   5.0  114];
    
    % This returns a matrix with the same number of rows anchors,
    % with each row representing the RGB values of that anchor.
    anccolours = [ ones(numel(x), 1) ...
                   (points(anclabels, 1) - min(X))./(max(X) - min(X)) ...
                   (points(anclabels, 2) - min(Y))./(max(Y) - min(Y))] * A;
end

% Local Variables:
% matlab-indent-level: 4
% End:
