function params  = DStriangulation(params, direction)
%TRIANGULATION: delaunay triangles and list of links on given points

    if strcmp(direction,'CTOR')
        positions = params.CTOR.coll_points;
        takeout = params.CTOR.takeout;
        numpoints = params.CTOR.numpoints;
    end

    if strcmp(direction,'RTOC')
        positions = params.RTOC.ret_points;
        takeout = params.RTOC.takeout;
        numpoints = params.RTOC.numpoints;
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
    
    if strcmp(direction,'CTOR')
        params.CTOR.triangles = triangles;
        params.CTOR.neighbours = neighbours;
    end

    if strcmp(direction,'RTOC')
        params.RTOC.triangles = triangles;
        params.RTOC.neighbours = neighbours;
    end

