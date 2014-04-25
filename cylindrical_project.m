function o_img = cylindrical_project(img, focal_length)
% formula: reference stitching ppt :p.34-36
% focal length = 625
    o_img = zeros(size(img), 'uint8');
    mid = size(img) / 2; % mid(1) = yc, mid(2) = xc

    for x = 1:size(img, 2)
        for y = 1:size(img, 1)
            px = x - mid(2);
            py = y - mid(1);
           
            theta = atan(px/focal_length);
            h = py / sqrt(px*px + focal_length*focal_length);

            x_new = round(focal_length*theta) + mid(2);
            y_new = round(focal_length*h) + mid(1);
    
            o_img(y_new, x_new, :, :) = img(y, x, :, :);
        end
    end


end

