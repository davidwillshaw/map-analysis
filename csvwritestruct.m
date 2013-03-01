function csvwritestruct(filename, s)
% CSVWRITESTRUCT - write a structure to a csv file
%   Write the structure S to a csv file FILENAME
%       
    s1 = unfold_structure(s);
    els = structfun(@format_element, s1, 'UniformOutput', false);
    cells = struct2cell(els);
    names = fieldnames(s1);
    if (length(cells) ~= length(names)) 
        error('Names and cells are different lengths')
    end
    f = fopen(filename, 'w');
    for (i = 1:length(names)) 
        fprintf(f, '"%s"', names{i});
        if (i ~= length(names))
            fprintf(f, ',');
        else                    
            fprintf(f, '\n');
        end
    end
    for (i = 1:length(names)) 
        fprintf(f, '%s', cells{i});
        if (i ~= length(names))
            fprintf(f, ',');
        else                    
            fprintf(f, '\n');
        end
    end
    fclose(f);
    
end

function out =  format_element(el) 
    if (isstr(el))
        out = sprintf('"%s"', el);
        return
    end
    if (isnumeric(el))
        if (prod(size(el)) == 1)
            out = sprintf('%f', el);
        else
            warning('Matrix or vector: outputting NA')
            out = sprintf('"NA"');
        end
        return
    end
    warning('Invalid format: outputting NA')
    out = sprintf('"NA"');
end   
    
