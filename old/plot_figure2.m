function [] = plot_figure2(params,takeout,FTOCanchors,CTOFanchors)
% PLOT_FIGURE2 - Plot lattices and orientation
%   Given the data structure PARAMS, plot lattices and orientation
%   from Field to Colliculus and Colliculus to Field. The optional
%   argument TAKEOUT specifies which nodes to take out in the FTOC
%   direction. The optional arguments FTOCANCHORS and CTOFANCHORS
%   specify which nodes to attach anchors to in either direction.
%
%   HISTORY:
%   Copied from Adrianna's plot_figure2.m
%   With the added facility of specifying which nodes to leave out
%   Also supply a list of nodes for anchors -separate lists for FTOC, CTOF

  % Default arguments
  if (~exist('FTOCanchors')) 
    FTOCanchors = [85:95,97];
  end 
  if (~exist('CTOFanchors')) 
    CTOFanchors = [85:95,97];
  end 
  
    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;




 
%FTOC
        field_coords = params.FTOC.field_points;
        coll_coords = params.FTOC.coll_points;
        list_of_neighbours = params.FTOC.list_of_neighbours;
        color = 'k';
        num_points = params.FTOC.numpoints;
        if (~exist('takeout'))
          takeout = params.FTOC.takeout;
        end
        list_of_points = setdiff(1:num_points,takeout);
        sets_of_intersections = params.FTOC.sets_of_intersections;
    
    figure(2)
    clf
   %FTOC Field
   ancnums=length(FTOCanchors);
   subplot(2,3,1)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1);
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1);
   print_links(list_of_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,ancnums,FTOCanchors);
   plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar
   axis ij
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off
   axis([-50 50 -50 50]);
   axis off
   title('Field');
   
   %FTOC Coll
   subplot(2,3,2)
   print_links(list_of_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,ancnums,FTOCanchors);
   plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar
   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off
   title('Colliculus');

   
   %FTOC circ_plot
   subplot(2,3,3)
%  minimal fix for figures
   angles = -params.FTOC.angles;
   norm_links = params.FTOC.norm_links;
   flipped_links = params.FTOC.flipped_links;
   circ_plot(angles(norm_links>0),'hist',color,40,false,true,'linewidth',2,'color',color);
   hold on
   circ_plot(angles(flipped_links>0),'hist','r',40,false,true,'linewidth',2,'color','r');
   title(params.datalabel);    
   
   %CTOF
    coll_coords = params.CTOF.coll_points;
    field_coords = params.CTOF.field_points;
    list_of_neighbours = params.CTOF.list_of_neighbours;
    color = 'b';
    num_points = params.CTOF.numpoints;
    takeout = params.CTOF.takeout;
    list_of_points = setdiff(1:num_points,takeout);
    sets_of_intersections = params.CTOF.sets_of_intersections;
    
    ancnums=length(CTOFanchors);   
       
   %CTOF Field
   subplot(2,3,4)
   plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1);
   hold on
   plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1);
   print_links(list_of_points, field_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, field_coords, list_of_crossings, 'r');
   anchors = plot_anchors(field_coords,ancnums,CTOFanchors);

   axis ij
   axis([-50 50 -50 50]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off
   
   %CTOF Coll
   subplot(2,3,5)
   print_links(list_of_points, coll_coords, list_of_neighbours, color);
   hold on
   [cross_points,list_of_crossings] = make_cross_list(list_of_points,sets_of_intersections);
   print_links(cross_points, coll_coords, list_of_crossings, 'r');
   plot_anchors(coll_coords,ancnums,CTOFanchors);

   axis ij
   axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
   set(gca,'PlotBoxAspectRatio',[1 1 1]);
   axis off
 
   
   %CTOF circ_plot
   subplot(2,3,6)
%   minimal fix for figures
   angles = -params.CTOF.angles;
   norm_links = params.CTOF.norm_links;
   flipped_links = params.CTOF.flipped_links;
   circ_plot(angles(norm_links>0),'hist',color,40,false,true,'linewidth',2,'color',color);
   hold on
   circ_plot(angles(flipped_links>0),'hist','r',40,false,true,'linewidth',2,'color','r');
   

   figure(2)
   orient tall
   filename = [num2str(params.id),'_fig2.pdf'];
   print(2,'-dpdf',filename)
   
         
   
   
