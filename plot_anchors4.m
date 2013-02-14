function anchors = plot_anchors4(points,num_anchors,anchors)
    

    num_points = length(points);
    if isempty(anchors)
        anchors = ceil(rand(num_anchors,1).*num_points);
    end
    
 COLOURS(5,:) = [0 0 1];  % blue 
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


% Colours set by hand
% dividing up MapAnsColor into 12
% COLOURS(1,:) = [1 1 0];  % yellow
% COLOURS(2,:) = [0.5 1 0]; %
% COLOURS(3,:) = [0 1 0];    %green
% COLOURS(4,:) = [0 1 0.5]; % 
% COLOURS(5,:) = [0 1 1];  % 
% COLOURS(6,:) = [0 0.5 1]; % 
% COLOURS(7,:) = [0 0 1]; %blue 
% COLOURS(8,:) = [0.5 0 1];  
% COLOURS(9,:) = [1 0 1]; %
% COLOURS(10,:)= [1 0 0.5]; %
% COLOURS(11,:) = [1 0 0];% red
% COLOURS(12,:) = [0 0 0];  %black


    for anchor = 1:num_anchors
%       norm_anchor=ceil(12*anchor/num_anchors);
       plot(points(anchors(anchor),1),points(anchors(anchor),2),'o','Color',COLOURS(anchor,:),'MarkerFaceColor',COLOURS(anchor,:),'MarkerSize',4);
    end
    
    
    
    
