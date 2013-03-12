function prunedEdges = JpruneGridTails(edges)

%               Johannis's program to remove tails
% Find the nodes that only have one edge, remove them, then
% repeat until all remaining nodes have two or more edges

disp('Pruning away the tails from the grid.')

prunedEdges = edges;
nRemoved = -1;

while(nRemoved ~= 0)
   nRemoved = 0;

   A = accumarray(prunedEdges(:),1)
   singleNodes = find(A == 1)

   for i = 1:numel(singleNodes)
       % Remove the edges that connect the single nodes
     [rowIdx,colIdx] = find(prunedEdges == singleNodes(i))
     prunedEdges(rowIdx,:) = []
     nRemoved = nRemoved + numel(rowIdx)
   end
end
