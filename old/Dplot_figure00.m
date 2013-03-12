function [] = Dplot_figure00(params,direction)

% Shows projection patterns from single nodes
% FTOC or CTOF

xmean_coll = params.ellipse.x0;
ymean_coll = params.ellipse.y0;

if direction=='FTOC'
   num_nodes = params.FTOC.numpoints;
   field_points = params.FTOC.field_points;
   from_coords = params.full_field;
   
   to_coords = params.full_coll;
   radius = params.field_radius;

num_figs = ceil(num_nodes/18);
point = 0;

for nf=1:num_figs
      fig_num = 8000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:35
	  point = point+1;
	  if point > num_nodes
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end

         subplot(6,6,nplot)
	 
	 node1=point;
         centre = field_points(node1,:);
	 [from_points,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
%	  scatter = sqrt(sum(var(projection_points)));
	  plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
	  hold on
	  plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
%          plot(from_points(:,1),from_points(:,2),'x','Color','g');
          plot(from_points(:,1),from_points(:,2),'.','Color','g');

	  if params.id ~=999
%         Scale bar
          plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar 20degrees
          axis([-50 50 -50 50]);
	  axis ij
          set(gca,'PlotBoxAspectRatio',[1 1 1])
          axis([-50 50 -50 50]);
          end

	  axis ij
          axis off
	  title(['#',num2str(params.id),', Node ',num2str(node1)]);
	  hold off


          subplot(6,6,nplot+1)

	  plot(projection_points1(:,1),projection_points1(:,2),'.','Color','g');
	  hold on

	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');

         
         if params.id ~=999
         plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar 250microns?
         axis ij
         axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
         set(gca,'PlotBoxAspectRatio',[1 1 1])
	 end
         axis off
         axis ij
%	  title(['COLLICULUS']);

%      set(gca,'XTick',[],'YTick',[]);


          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
%CTOF

if direction=='CTOF'
   num_nodes = params.CTOF.numpoints;
   coll_points = params.CTOF.coll_points;
   from_coords = params.full_coll;
   to_coords = params.full_field;
   radius = params.coll_radius;

num_figs = ceil(num_nodes/10);
point = 0;

for nf=1:num_figs
      fig_num = 9000+nf;
      figure(fig_num);
      clf
      
      for nplot =1:2:35
	  point = point+1;
	  if point > num_nodes
	     orient tall
             filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
             print(fig_num,'-dpdf',filename)
	     return
          end

         subplot(6,6,nplot)
	 
	 node1=point;
         centre = coll_points(node1,:);
	 [from_points1,projection_points1] = find_projection(centre,radius,from_coords,to_coords);
	  plot(zeros(101,1),-50:50,'Color',[0.7 0.7 0.7], 'Linewidth',1)
	  hold on
	  plot(-50:50,zeros(101,1),'Color',[0.7 0.7 0.7], 'Linewidth',1)
          plot(projection_points1(:,1),projection_points1(:,2),'.','Color','r');



%          plot(-45:-26,ones(20,1).*45,'k', 'LineWidth',3)%scale bar 20degrees
          axis([-50 50 -50 50]);
	  axis ij
          set(gca,'PlotBoxAspectRatio',[1 1 1])
          axis([-50 50 -50 50]);
          axis off
	  title(['#',num2str(params.id),',',num2str(node1)],'FontSize',8);
	  hold off


          subplot(6,6,nplot+1)

	  plot(from_points1(:,1),from_points1(:,2),'.','Color','r');
	  hold on

	  ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0,'k');


%         plot(xmean_coll-65:xmean_coll-38,ones(28,1).*ymean_coll+65,'k', 'LineWidth',3)%scale bar 250microns?
         axis ij
         axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
         set(gca,'PlotBoxAspectRatio',[1 1 1])
         axis off

%	  title(['COLLICULUS']);
%      set(gca,'XTick',[],'YTick',[]);

          end

   orient tall 
   filename = [num2str(params.id),'_fig',num2str(fig_num),'.pdf'];
   print(fig_num,'-dpdf',filename)
         
      end

end
