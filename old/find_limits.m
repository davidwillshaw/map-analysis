function [pic pic_index] = find_limits(figg,Ycoords,Xcoords,NN)

figure(1234)
clf


subplot(2,2,1)

pic=figg(Ycoords,Xcoords,:);

imagesc(pic);

subplot(2,2,2);


[pic_index,mapp] = rgb2ind(pic,NN);

imagesc(pic_index);

colormap(mapp);




