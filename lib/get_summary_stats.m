function get_summary_stats(datasets, varargin)
    

    if (nargin > 1) 
        p = validateInput(varargin, {'UseCache', 'GetParamsFunc'});
    else
        p = struct();
    end
    UseCache = false;
    if (isfield(p, 'UseCache'))
        UseCache = p.UseCache;
    end

    GetDatasetsFunc = 'getdatasets';
    if (isfield(p, 'GetDatasetsFunc'))
        GetDatasetsFunc = p.GetDatasetsFunc;
    end

    GetParamsFunc = 'getparams';
    if (isfield(p, 'GetParamsFunc'))
        GetParamsFunc = p.GetParamsFunc;
    end
    
    if isempty(datasets)
        datasets = eval([GetDatasetsFunc '()']);
    end

    
    num_datasets = length(datasets);

    % Collect data analysis
    ss = {};
    for i = 1:num_datasets
        id = datasets(i);
        disp(id);
        ss{i} = run_data_id(id, 0, 'UseCache', UseCache, ...
                            'GetParamsFunc', GetParamsFunc);
    end
    
    
    % Prepare FTOC output
    for i = 1:num_datasets
        ss{i}.percent_mult = 100/ss{i}.FTOC.numpoints;

        ss{i}.stats.FTOC = scale_quantities(ss{i}.stats.FTOC, ...
                                            ss{i}.field.scale, ...
                                            ss{i}.coll.scale, ...
                                            ss{i}.FTOC.numpoints);
        
        ss{i}.stats.CTOF = scale_quantities(ss{i}.stats.CTOF, ...
                                            ss{i}.coll.scale, ...
                                            ss{i}.field.scale, ...
                                            ss{i}.CTOF.numpoints);
        
        % ectopics
        coll_scale  = ss{i}.coll.scale;
        ss{i}.stats.num_ectopics  = ss{i}.stats.num_ectopics*ss{i}.percent_mult;                            
        ss{i}.stats.ect_dist_mean = ss{i}.stats.ect_dist_mean*coll_scale;                             
        ss{i}.stats.ect_dist_std  = ss{i}.stats.ect_dist_std*coll_scale;                              
        
        % mean_min_spacing
        field_scale = ss{i}.field.scale;
        ss{i}.FTOC.mean_min_spacing = ss{i}.FTOC.mean_min_spacing*field_scale;
        ss{i}.CTOF.mean_min_spacing = ss{i}.CTOF.mean_min_spacing*coll_scale;

        %  43,44 already in degrees

        % if ss{i}.stats.num_ectopics >= 6
        %     % changed this number from 5 to fix an error in #73
        %     ss{i}.stats.nodes_in_subgraph_major = ss{i}.stats.nodes_in_subgraph_major*percent_mult;
        %     ss{i}.stats.nodes_in_subgraph_minor = ss{i}.stats.nodes_in_subgraph_minor*percent_mult;
        %     %major
        %     ss{i}.stats.nodes_in_major = ss{i}.stats.nodes_in_major*percent_mult;
        %     %minor
        %     ss{i}.stats.nodes_in_minor = ss{i}.stats.nodes_in_minor*percent_mult;
        % end

        % Area of colliculus
        % ss(i,90) = params.ellipse.ra*params.ellipse.rb*pi*(8.9/1000)^2;
    end

% $$$ % Means, STDs for full set of data
% $$$ if num_datasets==20
% $$$        
% $$$         ss(21,:) = mean(ss([1:5],:));
% $$$         ss(22,:) = std(ss([1:5],:),1);
% $$$         ss(23,:) = sqrt(mean(ss([1:5],:).^2));
% $$$ 
% $$$         ss(24,:) = mean(ss([6:10],:));
% $$$         ss(25,:) = std(ss([6:10],:),1);
% $$$         ss(26,:) = sqrt(mean(ss([6:10],:).^2));
% $$$ 
% $$$         ss(27,:) = mean(ss([11:15],:),1);
% $$$         ss(28,:) = std(ss([11:15],:),1);
% $$$         ss(29,:) = sqrt(mean(ss([11:15],:).^2));
% $$$ 
% $$$         ss(30,:) = mean(ss([16:20],:),1);
% $$$         ss(31,:) = std(ss([16:20],:),1);
% $$$         ss(32,:) = sqrt(mean(ss([16:20],:).^2));
% $$$ end     

    csvwritestruct('summary_stats.csv', ss);
end 
  
function s = scale_quantities(s, inscale, outscale, numpoints) 
    degs=360/(2*pi);

    percent_mult = 100/numpoints;
    s.percent_mult = percent_mult;

    s.mag_factor = sqrt(s.field_area/s.coll_area);
    
    %full map orientation in degrees
    s.map_orientation_mean          = s.map_orientation_mean*degs;
    s.map_orientation_std           = s.map_orientation_std*degs;
    s.overall_dispersion_angle      = s.overall_dispersion_angle*degs;
    s.overall_dispersion_xrad       = s.overall_dispersion_xrad*outscale;
    s.overall_dispersion_yrad       = s.overall_dispersion_yrad*outscale;
    s.dispersion_xrad               = s.dispersion_xrad*outscale;
    s.dispersion_yrad               = s.dispersion_yrad*outscale;
    s.SEM_xrad                      = s.SEM_xrad*outscale;
    s.SEM_yrad                      = s.SEM_yrad*outscale;
    s.scatter_mean_in               = s.scatter_mean_in*inscale;
    s.scatter_mean_out              = s.scatter_mean_out*outscale;  

    % ordered subgraph 
    s.num_nodes_in_subgraph         = s.num_nodes_in_subgraph*percent_mult;
    s.subgraph_map_orientation_mean = s.subgraph_map_orientation_mean*degs;
    s.subgraph_map_orientation_std  = s.subgraph_map_orientation_std*degs;
    s.subgraph_overall_dispersion_angle = s.subgraph_overall_dispersion_angle*degs;          
    s.subgraph_dispersion_xrad      = s.subgraph_dispersion_xrad*outscale;             
    s.subgraph_dispersion_yrad      = s.subgraph_dispersion_yrad*outscale;             
    s.subgraph_SEM_xrad             = s.subgraph_SEM_xrad*outscale;
    s.subgraph_SEM_yrad             = s.subgraph_SEM_yrad*outscale;


    %baseline maps
    if (isfield(s, 'baseline'))
        s.baseline.num_crosses         = mean(s.baseline.num_crosses);
        s.baseline.num_nodes_crossing  = mean(s.baseline.num_nodes_crossing)*percent_mult;        
        s.baseline.num_nodes_in_submap = ...
            mean(s.baseline.num_nodes_in_submap)*percent_mult; 
    end
    if (isfield(s, 'lower_bound'))
        s.lower_bound                  = s.lower_bound*percent_mult;
    end
    
end

% Local Variables:
% matlab-indent-level: 4
% End:
