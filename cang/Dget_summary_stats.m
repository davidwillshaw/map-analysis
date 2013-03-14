function Dget_summary_stats(datasets, varargin)

if (nargin > 1) 
    p = validateInput(varargin, {'UseCache', 'GetParamsFunc'});
else
    p = struct();
end
UseCache = false;
if (isfield(p, 'UseCache'))
    UseCache = p.UseCache;
end

get_summary_stats(datasets, 'GetParamsFunc', 'Dgetparams', ...
                            'UseCache', UseCache)