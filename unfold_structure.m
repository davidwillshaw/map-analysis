function [names, out, sout] = unfold_structure(s, fun, parent)
    verbose = true;
    if (exist('fun') ~= 1)
        fun = '';
    end
    if (exist('parent') ~= 1)
        parent = '';
    end
    names = {};
    out = {};
    sout = struct();
    n = fieldnames(s);
    for (i = 1:length(n))
        field = getfield(s, n{i});
        if (isstruct(field)) 
            if (verbose) 
                disp([path(parent, n{i}), ' is structure'])
            end
            [names1 out1 sout1]  = unfold_structure(field, fun, path(parent, ...
                                                             n{i}));
            out = [out, out1];
            names1 = fieldnames(sout1)
            % names = [names, names1];
            sout1
            for (j = 1:length(names1))
                j
                name = names1{j}
                sout = setfield(sout, name, getfield(sout1, name));
            end
        else
            name  = path(parent, n{i});
            if (verbose)
                disp([name, ' is not structure'])
            end
            names = [names, name];
            sout = setfield(sout, name, field);
            if (length(fun) > 0) 
                out = [out, eval([fun, '(field)'])];
            else
                out = [out, field];
            end
        end
    end
    sout
end

function p = path(parent, child)
    if (length(parent) == 0)
        p = child;
    else
        p = [parent, '_', child];
    end
end
