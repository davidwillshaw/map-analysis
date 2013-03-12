function [] = Dplot_indiv_scatters(params,group,direction)

xmean_coll = params.ellipse.x0;
ymean_coll = params.ellipse.y0;

if strcmp(direction,'FTOC')    
%   num_points = params.FTOC.numpoints;
    field_points = params.FTOC.field_points;
    from_coords = params.full_field;
    to_coords = params.full_coll;
    radius = params.field_radius;

   ect= params.FTOC.stats.ectopics;
   long_fields =params.FTOC.stats.long_fields;
   short_fields = params.FTOC.stats.short_fields;

   if group == 1
        list_points = ect;
        SS= 'r';
   end

   if group == 2
       list_points = long_fields;
       SS= 'g';
   end

   if group == 3
       list_points = short_fields;
       SS= 'b';
   end

   num_points = length(list_points);
   disp(['Number of nodes: ',num2str(num_points)]);

   num_figs = ceil(num_points/10);
   point = 0;

   for nf=1:num_figs
      fig_num = group*1000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:19
	  point = point+1;
	  if point > num_points
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end
          centre = field_points(list_points(point),:);
	 [from_points,projection_points] = find_projection(centre,radius,from_coords,to_coords);
	  scatter = sqrt(sum(var(projection_points)));
            
	  subplot(5,4,nplot)
	  plot(from_points(:,1),from_points(:,2),'x','Color',SS);
	  hold on

%         add scale bar of 10 degrees
%         line([-40 -30],[40 40],'LineWidth',3,'Color','k')
%          line([0 0],[50 45],'Color','k');
%          line([-50 -45],[0 0],'Color','k');

          axis ij

	  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 12, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'});
          axis([-50 50 -50 50]);
	  title(['#',num2str(params.id),',node:',num2str(list_points(point)),': FIELD']);

          subplot(5,4,nplot+1)
	  plot(projection_points(:,1),projection_points(:,2),'x','Color',SS);
	  hold on


	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

%      add scale bar of 200 microns
%     line ([xmean_coll-60 xmean_coll-60+22.472],[ymean_coll+60 ymean_coll+60],'LineWidth',3,'Color','k');

	  axis ij
	  axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
	  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 14, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'});
	  title([num2str(list_points(point)),': COLLICULUS']);

%      set(gca,'XTick',[],'YTick',[]);
          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end
end

if strcmp(direction,'CTOF');
  coll_points = params.CTOF.coll_points;
  coll_points(params.CTOF.takeout,:) = [];
  from_coords = params.full_coll;
  to_coords = params.full_field;
  radius = params.coll_radius;
  num_points = params.CTOF.numpoints;
 
  group = 4
  SS = 'm';   
  list_points = [1:num_points];
  disp(['Number of nodes: ',num2str(num_points)]);

   num_figs = ceil(num_points/10);
   point = 0;

   for nf=1:num_figs
      fig_num = group*1000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:19
	  point = point+1;
	  if point > num_points
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end
          centre = coll_points(list_points(point),:);
	 [from_points,projection_points] = find_projection(centre,radius,from_coords,to_coords);
	  scatter = sqrt(sum(var(projection_points)));
            
	  subplot(5,4,nplot)
	  plot(projection_points(:,1),projection_points(:,2),'x','Color',SS);
	  hold on

%         add scale bar of 10 degrees
%         line([-40 -30],[40 40],'LineWidth',3,'Color','k')
%          line([0 0],[50 45],'Color','k');
%          line([-50 -45],[0 0],'Color','k');

          axis ij

	  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 12, 'XTick',[-50,0,50] ,'XTickLabel',{'-50','0','50'}, 'YTick',[-50,0,50] ,'YTickLabel',{'-50','0','50'});
          axis([-50 50 -50 50]);
	  title(['#',num2str(params.id),',node:',num2str(list_points(point)),': FIELD']);

          subplot(5,4,nplot+1)
	  plot(from_points(:,1),from_points(:,2),'x','Color',SS);
	  hold on


	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

%      add scale bar of 200 microns
%     line ([xmean_coll-60 xmean_coll-60+22.472],[ymean_coll+60 ymean_coll+60],'LineWidth',3,'Color','k');

	  axis ij
	  axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
	  set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 14, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'});
	  title([num2str(list_points(point)),': COLLICULUS']);

%      set(gca,'XTick',[],'YTick',[]);
          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end 
end
