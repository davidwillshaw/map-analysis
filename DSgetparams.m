function params = DSgetparams(id,N,radius)
%   Both retina and colliculus are inside unit square

        RANSTART=10101;


    params = struct('id',id);
    params.CTOR.numpoints = N;
    params.RTOC.numpoints = N;
    params.ranstart = RANSTART;
    params.coll_radius = radius;
    params.ret_radius =  radius;
    params.CTOR.takeout = [];
    params.RTOC.takeout = [];
    params.comments = '';
    params.anchors = 8;
    params.tolerance = 150;
    
    params.stats.id = id;
