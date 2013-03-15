function h = subplot2(nrow, ncol, pane)
% SUBPLOT2 - Modified version of subplot with larger margins
%   

h = subplot(nrow, ncol, pane);

row = ceil(pane/ncol);
col = mod(pane - 1, ncol) + 1;
disp(['Pane ' num2str(pane) ...
      ' Row ' num2str(row) '/' num2str(nrow) ...  
      ' Col ' num2str(col) '/' num2str(ncol) ])
inset = [1 1 1 1]*0.0;
set(h, 'LooseInset', inset);

mar = 0.02;
xfac = 0.97;
position = [xfac*((col - 1)/ncol) + mar, (nrow - row)/nrow + mar, ...
            xfac*1/ncol - 2*mar, 1/nrow - 2*mar];
set(h, 'Position', position);


