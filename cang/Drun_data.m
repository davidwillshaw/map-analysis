function params = Drun_data(id, ectopicnodes, varargin)
% DRUN_DATA - Wrapper for run_data.m    
    
    if (nargin > 2) 
        p = validateInput(varargin, {'UseCache', 'GetParamsFunc'});
    else
        p = struct();
    end
    UseCache = false;
    if (isfield(p, 'UseCache'))
        UseCache = p.UseCache;
    end

    params = run_data_id(id, ectopicnodes, 'GetParamsFunc', 'Dgetparams', ...
                      'UseCache', UseCache)
    
% Local Variables:
% matlab-indent-level: 4
% End:
