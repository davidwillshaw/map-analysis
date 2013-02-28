function params = Drun_data(id, ectopicnodes)

%  David's version of run_data.m 
% (i)   figure 306 added which plots individual scatters  YES
%       for whole field and for largest ordered subgraph
%       to mirror Figure 6, which shows the maps
% (ii ) Dfind_three_scatter_types counts the three types  NO
%       of FTOC scatter and plots out STDs of spread in Fig 33
%       Threshold set at 2 pixels
% (iii) Remove high scatter pixels   YES

    params = Dgetparams(id);
    disp(['Loading data ',num2str(id), '...'])
    params = load_data(params);
    
    if (length(params.preprocess_function) > 0) 
       if (exist(params.preprocess_function) == 2) 
           disp('Preprocessing data...')
           params = eval([params.preprocess_function '(params)']);
       else
           error(['Preprocessing function ], params.preprocess_function, ' ...
                  ' set in params.preprocess_function is not set'])
       end
    end

    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    params = select_point_positions(params,'FTOC');

    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    params = create_projection(params, 'FTOC');

%D  Fix for randomising FTOC along RC axis   OFF
%   NN = length(params.FTOC.coll_points(:,2));
%   params.FTOC.coll_points(:,2) = params.FTOC.coll_points(randperm(NN),2);
    disp('Finding ectopics...')
    params = Dfind_ectopics(params);
    params = triangulation(params,'CTOF');
    params = triangulation(params,'FTOC');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    params = find_crossings(params, 'FTOC');

    disp('Finding largest subgraph...')
    params = find_largest_subgraph(params,'CTOF',ectopicnodes);
    params = find_largest_subgraph(params,'FTOC',ectopicnodes);
    disp('Calculating stats...')
    disp(['--> dispersion (mean dispersion of complentary distributions)'])
    params = find_dispersion(params, 'FTOC');
    params = find_dispersion(params, 'CTOF');
    disp(['--> dispersion for subgraphs'])
    params = find_dispersion(params, 'FTOC', true);
    params = find_dispersion(params, 'CTOF', true);
    disp(['--> overall dispersion (dispersion of superposed ' ...
          'distribution)...'])
    params = find_overall_dispersion(params, 'FTOC');
    params = find_overall_dispersion(params, 'CTOF');
    disp(['--> overall dispersion of subgraphs'])
    params = find_overall_dispersion(params, 'FTOC', true);
    params = find_overall_dispersion(params, 'CTOF', true);
    disp('--> orientation...')
    params = find_link_angles(params,'FTOC');
    params = find_link_angles(params,'CTOF');
    params = find_subgraph_angle(params, 'FTOC');
    params = find_subgraph_angle(params, 'CTOF');
    disp('--> scatters...')
    params = get_subgraph_scatters(params,'FTOC');
    params = get_subgraph_scatters(params,'CTOF');
    disp('--> baseline...')
    params = find_baseline(params, 'FTOC', 5);
    params = find_baseline(params, 'CTOF', 5);
    disp('-->lower bound...')
    params = find_prob_subgraph(params,'FTOC');
    params = find_prob_subgraph(params,'CTOF');
    if params.stats.num_ectopics >= 5
        disp('--> ectopics...')
        params = ectopic_order_stats(params);
    end
    
%   params = Dfind_three_scatter_groups(params,2,1);    
%    params = Dplot_figure3(params);
%    params = Dcalc_disps_plot306_307(params);

    if (length(params.postprocess_function) > 0) 
       if (exist(params.postprocess_function) == 2) 
           params = eval([params.postprocess_function '(params)']);
       else
           error(['Postprocessing function ], params.postprocess_function, ' ...
                  ' set in params.postprocess_function is not set'])
       end
    end

% Local Variables:
% matlab-indent-level: 4
% End:
