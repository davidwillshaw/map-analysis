function params  = DStriangulation(params, direction)
%TRIANGULATION: delaunay triangles and list of links on given points

    if strcmp(direction,'CTOF')
        positions = params.CTOF.coll_points;
        takeout = params.CTOF.takeout;
        numpoints = params.CTOF.numpoints;
    end

    if strcmp(direction,'FTOC')
        positions = params.FTOC.field_points;
        takeout = params.FTOC.takeout;
        numpoints = params.FTOC.numpoints;
    end

    positions(takeout) = [];

    triangles = delaunay(positions(:,1),positions(:,2));;
    triangles = cleanup(triangles,positions,params.tolerance);
    num_triangles = size(triangles,1);
    neighbours = zeros(numpoints);

    for i=1:num_triangles,
        neighbours(triangles(i,1),triangles(i,2)) = 1;
        neighbours(triangles(i,2),triangles(i,1)) = 1;
        neighbours(triangles(i,1),triangles(i,3)) = 1;
        neighbours(triangles(i,3),triangles(i,1)) = 1;
        neighbours(triangles(i,2),triangles(i,3)) = 1;
        neighbours(triangles(i,3),triangles(i,2)) = 1;
    end
    
    if strcmp(direction,'CTOF')
        params.CTOF.triangles = triangles;
        params.CTOF.neighbours = neighbours;
    end

    if strcmp(direction,'FTOC')
        params.FTOC.triangles = triangles;
        params.FTOC.neighbours = neighbours;
    end

