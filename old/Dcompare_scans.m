function params= Dcompare_scans(params)
% comparing azimuthal and elevational plots
% before and after taking out high scatter points

new_elev=zeros(250,250);
new_azim= zeros(250,250);

elev = zeros(250,250);
azim=zeros(250,250);

for nn=1:params.num_active_pixels

    new_elev(params.full_coll(nn,2),params.full_coll(nn,1))=params.full_field(nn,1);

    new_azim(params.full_coll(nn,2),params.full_coll(nn,1))=params.full_field(nn,2);


end


figure(9875)
subplot(2,2,1)

elev = params.original_active_pixels.*params.elev_phase;
imagesc(elev);

axis square
axis ij


subplot(2,2,2);

azim = params.original_active_pixels.*params.azim_phase;
imagesc(azim);

axis square
axis ij

subplot(2,2,3)

imagesc(new_elev);

axis square
axis ij

subplot(2,2,4);

imagesc(new_azim);

axis square
axis ij


figure(9875)
orient tall
filename = [num2str(params.id),'_fig9875.pdf'];
print(9875,'-dpdf',filename)
   
