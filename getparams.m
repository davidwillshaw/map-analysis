function params = getparams(id,N,radius)
%   Both retina and colliculus are inside unit square
    if (~exist('radius'))
        radius = 1;
    end
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
   
    % Preprocessing function - this function given params
    % before any other processing takes place. It must return params.
    params.preprocess_function = '';
    
    % Scaling 
    
    % The size in some units (e.g. um) of one unit of distance in
    % the colliculus
    params.coll.scale = 1; 
    % Length of scalebar in the units defined above. If 0, no
    % scalebar plotted
    params.coll.scalebar = 0; 

    % The size in some units (e.g. degrees) of one unit of distance in
    % the field
    params.field.scale = 1; 
    % Length of scalebar in the units defined above. If 0, no
    % scalebar plotted
    params.field.scalebar = 0; 

    % Field plotting properties
    params.field.title = 'Field';
    params.field.xlabel = '';
    params.field.ylabel = '';
    % Centre of Field for plotting purposes
    params.field.xmean = 0.5;           
    params.field.ymean = 0.5;   
    params.field.XLim = [0, 1];
    params.field.YLim = [0, 1];
    params.field.XTick = [0 0.5 1];
    params.field.YTick = [0 0.5 1];
    params.field.XTickLabel = {'0','0.5','1'};
    params.field.YTickLabel = {'0','0.5','1'};
    params.field.FlipY = false;         % Flip Y-axis
    params.field.SuperposedHistBinSize = 0.01;
    params.field.SuperposedHistLim = 0.2;

    % Colliculus plotting properties
    params.coll.title = 'Colliculus';
    params.coll.xlabel = 'Anterior-Posterior';
    params.coll.ylabel = 'Medial-Lateral';
    % Centre of colliculus for plotting purposes
    params.coll.xmean = 0.5;           
    params.coll.ymean = 0.5;   
    params.coll.XLim = [0, 1];
    params.coll.YLim = [0, 1];
    params.coll.XTick = [0,0.5,1];
    params.coll.YTick = [0,0.5,1];
    params.coll.XTickLabel = {'0','0.5','1'};
    params.coll.YTickLabel = {'0','0.5','1'};    
    params.coll.FlipY = false;         % Flip Y-axis
    params.coll.SuperposedHistBinSize = 0.01;
    params.coll.SuperposedHistLim = 0.2;

    params.stats.id = id;

% Local Variables:
% matlab-indent-level: 4
% End:
