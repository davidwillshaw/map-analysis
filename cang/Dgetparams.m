function params = Dgetparams(id)
% New value of N and RANSTART set by hand - 17 Sept 2013
% Impossible to match up with Replications method?
% FTOC labels put in for the 2013 Paper

  CTOFlabels = [];

    if id ==999
%   zebrafinch trial
        EE = [190 160 0.50 260 225];
        N=10;
        RANSTART =12345;
    end

    if id ==88000
%   wildtype cortex data from Frank Sengpiel
      EE = [48 68 0.2 123 85];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 88022
%   cortex data from Frank Sengpiel SABBACK22
      EE = [48 75 0.5 113 92];
        N=160;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 88175
%   cortex data from Frank Sengpiel FRAX175
        EE = [42 62 0.5 103 87];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 88176
%   cortex data from Frank Sengpiel TDPV176
      EE = [38 68 0.5 95 90];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 881760
%   cortex data from Frank Sengpiel TDPV176recomposed complete??
      EE = [38 68 0.5 95 90];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 881761
%   cortex data from Frank Sengpiel TDPV176recomposed first half
      EE = [38 68 0.5 95 90];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 881762
%   cortex data from Frank Sengpiel TDPV176recomposed second half
      EE = [38 68 0.5 95 90];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 88178
%   cortex data from Frank Sengpiel FRAX178
        EE = [38 68 0.5 138 68];
        N=130;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

    if id == 88253
%   cortex data from Frank Sengpiel TDPV253NORM
      EE = [48 72 0.5 106 90];
        N=160;
%        N=300;
%        N=700;
        RANSTART =12345;
	FTOClabels = [17 53 70:72 74 80:82 99 126];
        CTOFlabels = [8 39 63:65 67 68 72 99 120];
    end

%--------------------------------------------------------



%  field radius changed from 1.6 to 1.7 7 Dec 2011

%    All parameters will give a mean minimum distance between collicular points of 6
%WT
    if id == 6
        EE = [68 60 0.95 119 154];
%        N = 15;
%        RANSTART = 3456;
         RANSTART = 1013;
         FTOClabels =[];
	 N = 175;
    end

    if id==80
        EE = [70 60 135 110 140];
%       N = 175;
        N = 160;
        RANSTART = 98;
        FTOClabels =[];
    end

    if id==10
        EE = [71 58 2.1 125 165];
        N = 175;
        RANSTART = 232323;
        FTOClabels = [99 102 104:109]
        % A10_random for randomised R->C axis
        % FTOClabels = [99 102 104 1 05 114];

%   15 Sept 2013
         RANSTART = 236763;
        % RANSTART = 236319;
        N = 159;
    end

    if id==15
        EE = [60 50 2.3562 118 138];
%       N = 134;
%       RANSTART = 55;
	N = 127;
        RANSTART = 910264;
        FTOClabels =[];
    end

    if id==73
        EE = [65 55 2.3562 122 142];
        N = 148;
        RANSTART = 983310;
        FTOClabels =[];
    end

%beta 2 KO
    if id==155
        N=120;
        RANSTART=9833;
        EE = [46 62 120 133 110];
        FTOClabels = [66 68:71 73];
    end

    if id==156
        N=120;
        RANSTART=9833;
        EE = [43 58.5 120 136 166];
        FTOClabels =[];
    end

    if id==163
%       N=75;
	N = 70;
        RANSTART=9833;
        EE = [45 38 2.1 163 153];
        FTOClabels =[];
    end

    if id==165
        N=115;
%       RANSTART=9833;
        RANSTART = 119833;
        EE = [54 42 2.1 170 144];
        FTOClabels =[];
    end

    if id==262;
%       N=115;
%       RANSTART=9833;
	N = 120;
        RANSTART = 993131;
        EE = [60 42 2.1 139 159];
        FTOClabels =[];
    end

%Het TKO

    if id==82
%       N=105;
        N = 88;
%        RANSTART=43;
%        RANSTART =10000;
        RANSTART = 10596;
        EE = [60 40 2.3562 160 140];
        FTOClabels = [48:53 55];
    end

    if id==84
        N=115;
        RANSTART=9833;
        EE = [50 45 2.3562 156 106];
        FTOClabels = [64:71]
    end

    if id==94
%       N=210;
%	N = 205;
%        RANSTART=431;
        N=197;
        RANSTART = 185202759;
        EE = [70 60 0.7584 140 130];
        FTOClabels = [92:98 101];
    end

    if id==161
%       N=97;
        N = 92;
        RANSTART=9833;
        EE = [35 50 -10 127 123];
        FTOClabels = [32 35 37:39 42 43];
    end

    if id==162
%	N=157;
        N = 144;
        RANSTART=431;
        EE = [70 50 -10 135 140];
        FTOClabels = [100:103 106];
    end

%Hom TKO

    if id==4
%       N=135;
%        N= 125;
%        RANSTART=10101;
        N = 120;;
        RANSTART = 5666;
        EE = [60 45 0.784 130 130];
%        EE = [60 45 0.784 150 100];
        FTOClabels = [91 93:97];
    end

    if id==54;
%       N=116;
        N = 105;
        RANSTART=22431;
        EE = [45 55 1.1636 146 109];
        FTOClabels = [31 33 38 69 71:73];
    end

    if id==55
%       N=130;
        N=110;
        RANSTART=431;
        EE = [48 60 0.7995 152 112];
        FTOClabels =[42:49];
    end

    if id==56
        N=165;
%	RANSTART=98765;
        N=149;
        RANSTART=4664;
        EE = [72 52 0.8 175 130];
        FTOClabels = [56:57 59:65];
    end

    if id==58
%        N=167;
        RANSTART=10101;
        N=162;
        EE = [72 52 2.3562 160 145];
        FTOClabels =  [24 26 27 29 30 31 147 149 150 151 155];
    end

% Beta2 A2 A5 knockout combo
    if id==17
        N=147;
        RANSTART=113121;
        EE = [60 60 -0.3 155 140];
        FTOClabels =  [24 26 27 29 30 31 147 149 150 151 155];
    end
 
    if id==18
       N=115;
       RANSTART=99999;
        EE = [50 50 -0.3 175 160];
        FTOClabels =  [24 26 27 29 30 31];
    end

    if id==27
        N=110;
        RANSTART=10101;
        EE = [50 50 -0.7 155 165];
        FTOClabels =  [24 26 27 29 30 31];
    end

    if id==38
      N=80;
        RANSTART=98761;
        EE = [48 57 -0.3 150 105];
        FTOClabels =  [24 26 27 29 30 31];
    end

%COMBO TKO from paper
    if id==1002
        N=210;
%  Query N = 210
        RANSTART=242;
        EE = [60 70 0.9 125 100];
        FTOClabels = [1 2 3 4];
    end

% Ephrin A3 Ki/Ki
    if id==115
        EE = [78 63 0.7853 130 120];
        N = 200;
        RANSTART = 48823;
        FTOClabels = [1 2 3 4];
    end

%  Michael Siebrecht 12345

    if id == 12345
        EE = [50 50 0  75 80];
        N = 200;
        RANSTART = 48823;
        FTOClabels = [1 2 3 4];
    end


    params = getparams(id, N);
    params.ellipse.ra = EE(1);
    params.ellipse.rb = EE(2);
    params.ellipse.ang = EE(3);
    params.ellipse.x0 = EE(4);
    params.ellipse.y0 = EE(5);
    params.ellipse_size = pi*EE(1)*EE(2);
    params.ranstart = RANSTART;
    params.coll_radius= 3;
    params.coll_min_points = (pi*params.coll_radius^2)/3;
    params.field_radius = 1.7
%   params.field_radius = 3.0;
%   params.field_radius = 1.13;
    params.field_min_points = 10;
    params.thresh.elev = 0.9;
    params.thresh.azim = 0;

    params.CTOF.lower_mean_min_spacing  = 5.9;    
    params.CTOF.upper_mean_min_spacing  = 6.1;    

    % Preprocessing function
    params.preprocess_function = 'Dpreprocess';
    params.thresh_scatter = 10;
    params.minclustersize = 5;

    % Postprocessing function
    % params.postprocess_function = 'Dpostprocess';
    
    % Scaling

    % The size in degrees of one unit of distance in the colliculus
    params.field.scale = 1; 
    % Length of scalebar in colliculus in degrees
    params.field.scalebar = 20; 
    % The length of one pixel in the colliculus is 8.9um; this setting
    % will give lengths in the colliculus measured in um and areas in
    % um^2
    params.coll.scale = 8.9; 
    % Length of scalebar in colliculus in um
    params.coll.scalebar = 250;

    params.FTOC.labels = FTOClabels;
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
    params.CTOF.labels = CTOFlabels;
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

% Local Variables:
% matlab-indent-level: 4
% End:
