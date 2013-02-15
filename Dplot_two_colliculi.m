function [] = Dplot_two_colliculi(PARAMS1,PARAMS2,SS)

figure(99)
clf

colormap(gray)
subplot(2,2,1)

params = PARAMS1;

imagesc(not(round(PARAMS1.active_pixels)));

hold on

[~, X_ELL, Y_ELL] = ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0);

xlabel('<--L--M--> (pixels)');
ylabel('<--C--R--> (pixels)');

title(['Activity pattern for dataset ',num2str(params.id)]);

axis ij 

axis image

hold off

subplot(2,2,2)

params = PARAMS2;

imagesc(not(round(params.active_pixels)));

hold on

[~, X_ELL, Y_ELL] = ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0);

xlabel('<--L--M--> (pixels)');
ylabel('<--C--R--> (pixels)');

title(SS);

axis ij 

axis image

hold off

subplot(2,2,3)

params = PARAMS1;

imagesc(not(round(PARAMS1.active_pixels-PARAMS2.active_pixels)));

hold on

[~, X_ELL, Y_ELL] = ellipse(params.ellipse.ra,params.ellipse.rb,params.ellipse.ang,params.ellipse.x0,params.ellipse.y0);

xlabel('<--L--M--> (pixels)');
ylabel('<--C--R--> (pixels)');

title('Difference');
axis ij 

axis image

hold off

orient tall

filename =[num2str(PARAMS1.id),'and',num2str(PARAMS2.id),'_fig99.pdf'];

print(99,'-dpdf',filename)
