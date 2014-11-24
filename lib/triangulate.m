function params  = triangulate(params, direction)
%TRIANGULATION: delaunay triangles and list of links on given points

    if strcmp(direction,'CTOF')
        positions = params.CTOF.coll_points;
        takeout = params.CTOF.takeout;
        numpoints = params.CTOF.numpoints;
        candidates = params.CTOF.candidates;
    end

    if strcmp(direction,'FTOC')
        positions = params.FTOC.field_points;
        takeout = params.FTOC.takeout;
        numpoints = params.FTOC.numpoints;
        candidates = params.FTOC.candidates;
    end


%    positions(takeout,:) = [];

     triangles = delaunay(positions(candidates,1),positions(candidates,2));
     triangles = cleanup(triangles,positions(candidates,:),params.tolerance);
     num_triangles = size(triangles,1);

    neighbours = zeros(numpoints);

    for i=1:num_triangles,
	neighbours(candidates(triangles(i,1)),candidates(triangles(i,2))) = 1;
        neighbours(candidates(triangles(i,2)),candidates(triangles(i,1))) = 1;
        neighbours(candidates(triangles(i,1)),candidates(triangles(i,3))) = 1;
        neighbours(candidates(triangles(i,3)),candidates(triangles(i,1))) = 1;
        neighbours(candidates(triangles(i,2)),candidates(triangles(i,3))) = 1;
        neighbours(candidates(triangles(i,3)),candidates(triangles(i,2))) = 1;
    end

   
    if strcmp(direction,'CTOF')
      params.CTOF.triangles = candidates(triangles);
      params.CTOF.neighbours = neighbours;
    end

    if strcmp(direction,'FTOC')
      params.FTOC.triangles = candidates(triangles);
        params.FTOC.neighbours = neighbours;
    end

triangles
