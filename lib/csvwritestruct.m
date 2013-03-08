function csvwritestruct(filename, s)
% CSVWRITESTRUCT - write a structure to a csv file 
%
%   Write the cell array of structures S to a csv file FILENAME. If
%   a structure in the array is hieararhical it is unfolded. 
%    
% See also unfold_structure      
    verbose = false;
    
    if (iscell(s)) 
        f = fopen(filename, 'w');
        % Template structure: contains all field names
        temp = struct();
        for (k = 1:length(s))
            s1 = unfold_structure(s{k});
            names = fieldnames(s1);
            for (i = 1:length(names)) 
                temp = setfield(temp, names{i}, 1);
            end
        end
        
        % Get and print field names
        names = fieldnames(temp);
        for (i = 1:length(names)) 
            fprintf(f, '"%s"', names{i});
            if (i ~= length(names))
                fprintf(f, ',');
            else                    
                fprintf(f, '\n');
            end
        end

        % Go through each structure
        for (k = 1:length(s))
            s1 = unfold_structure(s{k});
            for (i = 1:length(names))
                if (isfield(s1, names{i}))
                    out = format_element(getfield(s1, names{i}), verbose);
                else
                    out = '"NA"';
                end
                fprintf(f, out);
                if (i ~= length(names))
                    fprintf(f, ',');
                else                    
                    fprintf(f, '\n');
                end
            end
        end
        fclose(f);
    end
end

function out = format_element(el, verbose) 
    if (isstr(el))
        out = sprintf('"%s"', el);
        return
    end
    if (isnumeric(el))
        if (prod(size(el)) == 1)
            out = sprintf('%f', el);
        else
            if (verbose == true)
                warning('Matrix or vector: outputting NA')
            end
            out = sprintf('"NA"');
        end
        return
    end
    if (verbose == true)
        warning('Invalid format: outputting NA')
    end
    out = sprintf('"NA"');
end   
    
