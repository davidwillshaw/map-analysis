function [] = plot_ectopics(params)

    xmean_coll = params.ellipse.x0;
    ymean_coll = params.ellipse.y0;
    
    figure(10)
    clf
    %Field
    subplot(1,2,1)
    
    field_points = params.FTOC.field_points;
    major_projection = params.FTOC.major_projection;
    minor_projection = params.FTOC.minor_projection;
    [ect,~] = find(minor_projection);
    ect = unique(ect);
    
    for i = 1:size(field_points)
        plot(field_points(i,1),field_points(i,2),'ko','MarkerFaceColor', get_colour(field_points(i,1),field_points(i,2)), 'MarkerSize',8)
        hold on
    end
    plot(field_points(ect,1),field_points(ect,2),'k*', 'MarkerSize',8)
    axis ij
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[-50, 0, 50] , 'YTick',[-50 0 50])
    axis([-50,50,-50,50])
    xlabel('<--Inferior---Superior (degrees)-->');
    ylabel('<--Temporal---Nasal (degrees)-->');
    title(['DATA = ', num2str(params.id),', black circles indicate points that result in ectopics'])
    
    %Coll
    subplot(1,2,2)
    
    for i = 1:size(major_projection)
        plot(major_projection(i,1),major_projection(i,2),'ko','MarkerFaceColor', get_colour(field_points(i,1),field_points(i,2)), 'MarkerSize',8)
        hold on
        if ismember(i,ect)
            plot(minor_projection(i,1),minor_projection(i,2),'ko','MarkerFaceColor', get_colour(field_points(i,1),field_points(i,2)), 'MarkerSize',4)
        end
    end
    
    line([minor_projection(ect,1)';major_projection(ect,1)'],[minor_projection(ect,2)'; major_projection(ect,2)'],'Color','k')
    axis ij
    axis([xmean_coll-70 xmean_coll+70 ymean_coll-70 ymean_coll+70]);
    set(gca,'PlotBoxAspectRatio',[1 1 1], 'FontSize', 16, 'XTick',[xmean_coll-70,xmean_coll-70+56,xmean_coll-70+112] ,'XTickLabel',{'0','0.5','1'}, 'YTick',[ymean_coll-70,ymean_coll-70+56,ymean_coll-70+112] ,'YTickLabel',{'0','0.5','1'})
    xlabel('<--Lateral---Medial (pixels)-->');
    ylabel('<--Caudal---Rostral (pixels)-->');
    
    figure(10)
    filename = [num2str(params.id),'_fig10.pdf'];
    print(10,'-dpdf',filename)