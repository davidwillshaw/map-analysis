function params = getparams(id)

%WT
    if id == 6
        EE = [68 60 0.95 119 154];
        N = 152;
        RANSTART = 42393;
    end

    if id==80
        EE = [70 60 135 110 140];
        N = 145;
        RANSTART = 116;
    end

    if id==10
        EE = [71 58 2.1 125 165];
        N = 145;
        RANSTART = 423;
    end

    if id==15
        EE = [60 50 2.3562 118 138];
        N = 114;
        RANSTART = 501;
    end

    if id==73
        EE = [65 55 2.3562 122 142];
        N = 136;
        RANSTART = 423;
    end

%beta 2 KO
    if id==155
        N=108;
        RANSTART=42393;
        EE = [46 62 120 133 110];
    end

    if id==156
        N=98;
        RANSTART=43;
        EE = [43 58.5 120 136 166];
    end

    if id==163
        N=65;
        RANSTART=43;
        EE = [45 38 2.1 163 153];
    end

    if id==165
        N=95;
        RANSTART=43;
        EE = [54 42 2.1 170 144];
    end

    if id==262;
        N=98;
        RANSTART=43;
        EE = [60 42 2.1 139 159];
    end

%Het TKO

    if id==82
        N=91;
        RANSTART=43;
        EE = [60 40 2.3562 160 140];
    end

    if id==84
        N=100;
        RANSTART=431;
        EE = [50 45 2.3562 156 106];
    end

    if id==94
        N=175;
        RANSTART=431;
        EE = [70 60 0.7584 140 130];
    end

    if id==161
        N=85;
        RANSTART=431;
        EE = [35 50 -10 127 123];
    end

    if id==162
        N=135;
        RANSTART=431;
        EE = [70 50 -10 135 140];
    end

%Hom TKO

    if id==4
        N=115;
        RANSTART=77431;
        EE = [60 45 0.784 130 130];
    end

    if id==54;
        N=97;
        RANSTART=431;
        EE = [45 55 1.1636 146 109];
    end

    if id==55
        N=115;
        RANSTART=431;
        EE = [48 60 0.7995 152 112];
    end

    if id==56
        N=143;
        RANSTART=431;
        EE = [72 52 0.8 175 130];
    end

    if id==58
        N=145;
        RANSTART=431;
        EE = [72 52 2.3562 160 145];
    end

%COMBO TKO from paper

    if id==1002
        N=160;
        RANSTART=242;
        EE = [60 70 0.9 125 100];
    end

% Ephrin A3 Ki/Ki
    if id==115
        EE = [78 63 0.7853 130 120];
        N = 158;
        RANSTART = 423;
    end

    params = struct('id',id);
    params.ellipse.ra = EE(1);
    params.ellipse.rb = EE(2);
    params.ellipse.ang = EE(3);
    params.ellipse.x0 = EE(4);
    params.ellipse.y0 = EE(5);
    params.CTOF.numpoints = N;
    params.FTOC.numpoints = N;
    params.ranstart = RANSTART;
    params.coll_radius = 3;
    params.field_radius = 1.5;
    params.thresh.elev = 0.9;
    params.thresh.azim = 0;
    params.CTOF.takeout = [];
    params.FTOC.takeout = [];
    params.comments = '';
    params.anchors = 8;
    params.tolerance = 150;
    
    params.stats.id = id;
