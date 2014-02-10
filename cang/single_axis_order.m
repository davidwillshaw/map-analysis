function [ML_whole ML_sub RC_whole RC_sub] = single_axis_order(params)

neighbours = params.FTOC.list_of_neighbours;
take_out = params.FTOC.points_not_in_subgraph;
neighbours_sg = remove_links_including_nodes(neighbours, take_out);

new_field_points = rotate_field(params);

%fp = params.FTOC.field_points(:,1);

fp = new_field_points(:,1);

cp = params.FTOC.coll_points(:,1);

DISCRIM =(fp(neighbours(:,1))-fp(neighbours(:,2))).*(cp(neighbours(:,1))-cp(neighbours(:,2)));

IGOOD = find(DISCRIM > 0);
IBAD = find(DISCRIM < 0);

ML_whole =  100*length(IGOOD)/(length(IGOOD)+length(IBAD));


DISCRIM =(fp(neighbours_sg(:,1))-fp(neighbours_sg(:,2))).*(cp(neighbours_sg(:,1))-cp(neighbours_sg(:,2)));

IGOOD = find(DISCRIM > 0);
IBAD = find(DISCRIM < 0);
  
ML_sub =100*length(IGOOD)/(length(IGOOD)+length(IBAD));

%fp = params.FTOC.field_points(:,2);
fp = new_field_points(:,2);

cp = params.FTOC.coll_points(:,2);

DISCRIM =(fp(neighbours(:,1))-fp(neighbours(:,2))).*(cp(neighbours(:,1))-cp(neighbours(:,2)));

IGOOD = find(DISCRIM > 0);
IBAD = find(DISCRIM < 0);

RC_whole =  100*length(IGOOD)/(length(IGOOD)+length(IBAD));


DISCRIM =(fp(neighbours_sg(:,1))-fp(neighbours_sg(:,2))).*(cp(neighbours_sg(:,1))-cp(neighbours_sg(:,2)));

IGOOD = find(DISCRIM > 0);
IBAD = find(DISCRIM < 0);
  
RC_sub =100*length(IGOOD)/(length(IGOOD)+length(IBAD));


















































































































































































































