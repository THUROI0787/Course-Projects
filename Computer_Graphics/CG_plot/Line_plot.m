function [bin_image] = Line_plot(start, terminate, size)
%Plot the Line in the binary picture using Bresenham method.
%   [bin_image] = Line_plot(start, terminate, size)
%Input:  start    : start point of the line.
%        terminate: end point of the line.
%                   the Maximum of the coordinats is 1.
%        size     : the size of the picture to be ploted.
%Output: bin_imag: plot the line in the image.
    bin_image = zeros(size); point = [start, terminate];
    for i = 1:length(point(1,:))
        point(1,i) = floor(point(1,i) * size(1))+1;
        point(2,i) = floor(point(2,i) * size(2))+1;
        if point(1, i) > size(1); point(1, i) = size(1); end
        if point(2, i) > size(2); point(2, i) = size(2); end
    end
    t = point(1,:); point(1,:) = size(2)+1-point(2,:); point(2,:) = t;
    x = point(1,1); y = point(2,1);
    dx = point(1,2) - point(1,1);
    dy = point(2,2) - point(2,1);
    if dx > 0
        step_x = 1;
    else
        step_x = -1; dx = -dx;
    end
    if dy > 0
        step_y = 1;
    else
        step_y = -1; dy = -dy;
    end
    if dx > dy
        p = 2 * dy - dx;
        while x ~= point(1,2)
            bin_image(x, y) = 1;
            x = x + step_x;
            if p < 0
                p = 2 * dy + p;
            else
                y = y + step_y;
                p = 2 * (dy - dx) + p;
            end
        end
        bin_image(x, y) = 1;
    else
        p = 2 * dx - dy;
        while y ~= point(2,2)
            bin_image(x, y) = 1;
            y = y + step_y;
            if p < 0
                p = 2 * dx + p;
            else
                x = x + step_x;
                p = 2 * (dx - dy) + p;
            end
        end
        bin_image(x, y) = 1;
    end
end

