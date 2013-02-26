function params = Dgetparams(id)

    if id ==999
%   zebrafish trial
        EE = [190 160 0.50 260 225];
        N=10;
        RANSTART =12345;
    end
%  field radius changed from 1.6 to 1.7 7 Dec 2011

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
%	N=10;
%	N=9;
%	N=8;
        RANSTART=10101;
        EE = [60 45 0.784 130 130];
    end

    if id==54;
        N=116;
%	N=10;
%	N=9;
        RANSTART=22431;
        EE = [45 55 1.1636 146 109];
    end

    if id==55
        N=130;
%       N=10;
        RANSTART=431;
        EE = [48 60 0.7995 152 112];
    end

    if id==56
        N=165;
%        N=12;
%	RANSTART=98765;
%	N=11;
%	N=9;
%       N=8;
        RANSTART=10101;
        EE = [72 52 0.8 175 130];
    end

    if id==58
        N=167;
% 	N=10;
%       N=7;
%       N=9;
%       N=8;
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

    params = getparams(id, N);
    params.ellipse.ra = EE(1);
    params.ellipse.rb = EE(2);
    params.ellipse.ang = EE(3);
    params.ellipse.x0 = EE(4);
    params.ellipse.y0 = EE(5);
    params.ellipse_size = pi*EE(1)*EE(2);
    params.ranstart = RANSTART;
    params.coll_radius = 3;
%    params.field_radius = 3.0;
    params.field_radius = 1.7;
    params.thresh.elev = 0.9;
    params.thresh.azim = 0;

    % Scaling

    % The the size in degrees of one unit of distance in the colliculus
    params.field.scale = 1; 
    % Length of scalebar in colliculus in degrees
    params.field.scalebar = 20; 
    % The length of one pixel in the colliculus is 8.9um; this setting
    % will give lengths in the colliculus measured in um and areas in
    % um^2
    params.coll.scale = 8.9; 
    % Length of scalebar in colliculus in um
    params.coll.scalebar = 250;

    % Field plotting properties
    params.field.title = 'Field';
    params.field.xlabel = '';
    params.field.ylabel = '';
    % Centre of field for plotting purposes
    params.field.xmean = 0;           
    params.field.ymean = 0;   
    params.field.XLim = [-50 50];
    params.field.YLim = [-50 50];
    params.field.XTick = [-50,0,50];
    params.field.YTick = [-50,0,50];
    params.field.XTickLabel = {'-50','0','50'};
    params.field.YTickLabel = {'-50','0','50'};    
    params.field.FlipY = true;    
    params.field.SuperposedHistBinSize = 1;
    params.field.SuperposedHistLim = 20;
    
    % Colliculus plotting properties
    params.coll.title = 'Colliculus';
    params.coll.xlabel = 'Anterior-Posterior';
    params.coll.ylabel = 'Medial-Lateral';
    % Centre of colliculus for plotting purposes
    params.coll.xmean = params.ellipse.x0;
    params.coll.ymean = params.ellipse.y0;
    params.coll.XLim = [params.coll.xmean - 70, params.coll.xmean + 70];
    params.coll.YLim = [params.coll.ymean - 70, params.coll.ymean + 70];
    params.coll.XTick = [params.coll.xmean-70, ...
                        params.coll.xmean-70+56, ...
                        params.coll.xmean-70+112];
    params.coll.YTick = [params.coll.ymean-70, ...
                        params.coll.ymean-70+56, ...
                        params.coll.ymean-70+112];
    params.coll.XTickLabel = {'0','0.5','1'};
    params.coll.YTickLabel = {'0','0.5','1'};    
    params.coll.FlipY = true;         % Flip Y-axis
    params.coll.SuperposedHistBinSize = 1;
    params.coll.SuperposedHistLim = 56;
    
    if id == 999
%    radius = sqrt(A*B/N)
%    1 pixel = 10 microns
%    1 pixel equiv to 0.2817 degrees
       params.coll_radius = 3;
       params.field_radius =1.7;
       params.thresh.azim= 1.0;
       params.thresh.elev= 1.0;
    end
