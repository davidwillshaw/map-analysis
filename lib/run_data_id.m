function params = run_data_id(id, ectopicnodes, varargin)

%  David's version of run_data.m 
% (i)   figure 306 added which plots individual scatters  YES
%       for whole field and for largest ordered subgraph
%       to mirror Figure 6, which shows the maps
% (ii ) Dfind_three_scatter_types counts the three types  NO
%       of FTOC scatter and plots out STDs of spread in Fig 33
%       Threshold set at 2 pixels
% (iii) Remove high scatter pixels   YES
    if (nargin > 2) 
        p = validateInput(varargin, {'UseCache', 'GetParamsFunc'});
    else
        p = struct();
    end
    UseCache = false;
    if (isfield(p, 'UseCache'))
        UseCache = p.UseCache;
        disp('Loading from cache')
    end
    GetParamsFunc = 'getparams';
    if (isfield(p, 'GetParamsFunc'))
        GetParamsFunc = p.GetParamsFunc;
    end
    
    idstr = ['id', num2str(id)];
    global CACHE;
    if (exist('CACHE') ~= 1)
        CACHE = struct()
    else
        if (isfield(CACHE, idstr) && UseCache)
            params = getfield(CACHE, idstr);
            return 
        end
    end
    
    params = eval([GetParamsFunc, '(', num2str(id), ')']);
    
    % Call run_data itself
    params = run_data(params);
    
    CACHE = setfield(CACHE, idstr, params);
    
% Local Variables:
% matlab-indent-level: 4
% End:
