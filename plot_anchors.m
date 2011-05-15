function anchors = plot_anchors(points,num_anchors,anchors)
    
    num_points = length(points);
    if isempty(anchors)
        anchors = ceil(rand(num_anchors,1).*num_points);
    end
    
    COLOURS(1,:) = [0 0 1];  % blue 
    COLOURS(2,:) = [0 1 0]; % green
    COLOURS(3,:) = [0 1 1];    %cyan
    COLOURS(4,:) = [1 0.5 0]; % orange
    COLOURS(5,:) = [1 0 1];  % magenta
    COLOURS(6,:) = [1 0 0]; % red
    COLOURS(7,:) = [0.1 0.5 0 ]; % dark green
    COLOURS(8,:) = [1 1 0];  %yellow
    COLOURS(9,:) = [0.5 0 0]; % dark red
    COLOURS(10,:)=[0 0 0]; %black
    COLOURS(11,:) = [0.5 0.5 0.5];% gray
    COLOURS(12,:) = [0 0.5 0];  %dark green
    
    scatter(points(anchors,1),points(anchors,2),60,COLOURS(1:num_anchors,:),'filled');
    
    
    
    