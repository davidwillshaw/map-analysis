function colour = get_colour(x_coord,y_coord)

    if x_coord > -50 && x_coord < 50 && y_coord > -50 && y_coord < 50

        colour(1) = (y_coord + 50)/100;
        colour(2) = (x_coord + 50)/100;
        colour(3) = 1 - (y_coord + 50)/100;
    else
       disp('Error: coords should be between -50 and 50')
    end