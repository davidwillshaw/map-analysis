function params = run_data(params, varargin)
    
    if nargin > 1
        p = validateInput(varargin, {'Baseline'});
    else
        p = struct();
    end

    Baseline = validateArg(p, 'Baseline', true, {});
    
    ectopicnodes = 1;
    if (length(params.preprocess_function) > 0) 
       if (exist(params.preprocess_function) == 2) 
           disp('Preprocessing data...')
           params = eval([params.preprocess_function '(params)']);
       else
           error(['Preprocessing function ], params.preprocess_function, ' ...
                  ' set in params.preprocess_function is not set'])
       end
    end

    disp('Ensuring point positions unique...')
    params = uniquify_point_positions(params, 'CTOF');
    params = uniquify_point_positions(params, 'FTOC');
    
    disp('Selecting point positions...')
    params = select_point_positions(params,'CTOF');
    params = select_point_positions(params,'FTOC');

    disp('Creating projection...')
    params = create_projection(params, 'CTOF');
    params = create_projection(params, 'FTOC');

%D  Fix for randomising FTOC along RC axis   OFF
%D  Note - FtoC ONLY
%    NN = length(params.FTOC.coll_points(:,2));
%    params.FTOC.coll_points(:,2) = params.FTOC.coll_points(randperm(NN),2);


    disp('Finding ectopics...')
    params = find_ectopics(params,'FTOC');
    params = find_ectopics(params,'CTOF');

    params = triangulate(params,'CTOF');
    params = triangulate(params,'FTOC');
    disp('Finding crossings...')
    params = find_crossings(params, 'CTOF');
    params = find_crossings(params, 'FTOC');

    disp('Finding largest subgraph...')
    params = find_largest_subgraph(params,'CTOF',ectopicnodes);
    params = find_largest_subgraph(params,'FTOC',ectopicnodes);
    disp('Calculating stats...')
    disp(['--> dispersion (mean dispersion of complementary distributions)'])
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
    params = find_link_angles(params,'FTOC',1);
    params = find_link_angles(params,'FTOC',0);
    params = find_link_angles(params,'CTOF',1);
    params = find_link_angles(params,'CTOF',0);


    disp('--> polarity...')
    params=single_axis_order(params);

    disp('--> scatters...')
    params = get_subgraph_scatters(params,'FTOC');
    params = get_subgraph_scatters(params,'CTOF');
    if (Baseline)
        disp('--> baseline...')
        params = find_baseline(params, 'FTOC', 5);
        params = find_baseline(params, 'CTOF', 5);
        disp('-->lower bound...')
        if (license('checkout', 'optimization_toolbox'))
            params = find_prob_subgraph(params,'FTOC');
            params = find_prob_subgraph(params,'CTOF');
        end
    end

    if params.stats.FTOC.num_ectopics >= 5
        disp('--> ectopics...')
      params = ectopic_order_stats(params,'FTOC');
    end

    if params.stats.CTOF.num_ectopics >= 5
        disp('--> ectopics...')
      params = ectopic_order_stats(params,'CTOF');
    end

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
