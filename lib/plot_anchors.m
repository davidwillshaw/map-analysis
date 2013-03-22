function anclabels = plot_anchors(points, num_anchors, anclabels, ...
                                  ancsize, anccols)
    if (nargin <= 4) 
        anccols = [];
    end
        
    num_points = length(points);
    if isempty(anclabels)
        anchors = ceil(rand(num_anchors,1).*num_points);
    else
        num_anchors = length(anclabels);
    end

    if (isempty(anccols))
        COLOURS(5,:) = [0.5 0 1];  % red-blue 
        COLOURS(2,:) = [0 1 0]; % green
        COLOURS(3,:) = [0 1 1];    %cyan
        COLOURS(4,:) = [1 0.5 0]; % orange
        COLOURS(1,:) = [1 0 1];  % magenta
        COLOURS(6,:) = [1 0 0]; % red
        COLOURS(7,:) = [0.1 0.5 0 ]; % dark green
        COLOURS(8,:) = [1 1 0];  %yellow
        COLOURS(9,:) = [0.5 0 0]; % dark red
        COLOURS(10,:)=[0 0 0]; %black
        COLOURS(11,:) = [0.5 0.5 0.5];% gray
        COLOURS(12,:) = [0 0.5 0];  %dark green
    else    
        COLOURS = anccols;
    end

    while (size(COLOURS, 1) < num_anchors)
        COLOURS = [COLOURS; COLOURS];
        warning('Not enough colours specified; recycling colours')
    end
    
    for anchor = 1:num_anchors
        plot(points(anclabels(anchor), 1), ...
             points(anclabels(anchor), 2), ...
             'o', 'Color', COLOURS(anchor,:), ...
             'MarkerFaceColor', COLOURS(anchor,:), ...
             'MarkerSize', ancsize);
    end
    
% Local Variables:
% matlab-indent-level: 4
% End:
