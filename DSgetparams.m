function params = DSgetparams(id,N,radius)
%   Both retina and colliculus are inside unit square

        RANSTART=10101;


    params = struct('id',id);
    params.CTOF.numpoints = N;
    params.FTOC.numpoints = N;
    params.ranstart = RANSTART;
    params.coll_radius = radius;
    params.field_radius =  radius;
    params.CTOF.takeout = [];
    params.FTOC.takeout = [];
    params.comments = '';
    params.anchors = 8;
    params.tolerance = 150;
    
    params.stats.id = id;
