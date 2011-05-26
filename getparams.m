function params = getparams(id)

%    All parameters will give a mean minimum distance between collicular points of 6
%WT
    if id == 6
        EE = [68 60 0.95 119 154];
        N = 175;
        RANSTART = 3456;
    end

    if id==80
        EE = [70 60 135 110 140];
        N = 175;
        RANSTART = 98;
    end

    if id==10
        EE = [71 58 2.1 125 165];
        N = 175;
        RANSTART = 232323;
    end

    if id==15
        EE = [60 50 2.3562 118 138];
        N = 134;
        RANSTART = 55;
    end

    if id==73
        EE = [65 55 2.3562 122 142];
        N = 158;
        RANSTART = 983310;
    end

%beta 2 KO
    if id==155
        N=130;
        RANSTART=9833;
        EE = [46 62 120 133 110];
    end

    if id==156
        N=120;
        RANSTART=9833;
        EE = [43 58.5 120 136 166];
    end

    if id==163
        N=75;
        RANSTART=9833;
        EE = [45 38 2.1 163 153];
    end

    if id==165
        N=115;
        RANSTART=9833;
        EE = [54 42 2.1 170 144];
    end

    if id==262;
        N=115;
        RANSTART=9833;
        EE = [60 42 2.1 139 159];
    end

%Het TKO

    if id==82
        N=105;
        RANSTART=43;
        EE = [60 40 2.3562 160 140];
    end

    if id==84
        N=115;
        RANSTART=9833;
        EE = [50 45 2.3562 156 106];
    end

    if id==94
        N=210;
        RANSTART=431;
        EE = [70 60 0.7584 140 130];
    end

    if id==161
        N=97;
        RANSTART=9833;
        EE = [35 50 -10 127 123];
    end

    if id==162
        N=157;
        RANSTART=431;
        EE = [70 50 -10 135 140];
    end

%Hom TKO

    if id==4
        N=135;
        RANSTART=10101;
        EE = [60 45 0.784 130 130];
    end

    if id==54;
        N=116;
        RANSTART=22431;
        EE = [45 55 1.1636 146 109];
    end

    if id==55
        N=130;
        RANSTART=431;
        EE = [48 60 0.7995 152 112];
    end

    if id==56
        N=165;
        RANSTART=10101;
        EE = [72 52 0.8 175 130];
    end

    if id==58
        N=167;
        RANSTART=10101;
        EE = [72 52 2.3562 160 145];
    end

%COMBO TKO from paper
    if id==1002
        N=190;
        RANSTART=242;
        EE = [60 70 0.9 125 100];
    end

% Ephrin A3 Ki/Ki
    if id==115
        EE = [78 63 0.7853 130 120];
        N = 200;
        RANSTART = 48823;
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
    params.field_radius = 1.6;
    params.thresh.elev = 0.9;
    params.thresh.azim = 0;
    params.CTOF.takeout = [];
    params.FTOC.takeout = [];
    params.comments = '';
    params.anchors = 8;
    params.tolerance = 150;
    
    params.stats.id = id;
