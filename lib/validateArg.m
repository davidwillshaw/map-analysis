function val = validateArg(p, arg, default, allowed) 
    if (~exist(default))
        default = false;
    end
    if (~iscell(allowed))
        allowed = false;
    end
    
    if (iscell(allowed))
        val = default;
        if isfield(p, arg)
            val = getfield(p, arg);
            if (~ismember(val, allowed))
                argstr = [];
                for i=1:length(allowed)
                    argstr = [argstr sprintf('''%s'' ', allowed{i})];
                end
                error(['''' val ''' is not an allowed option for ''' ...
                       arg '''. Select one of ' argstr '.'])
            end
        end
    end
end    
