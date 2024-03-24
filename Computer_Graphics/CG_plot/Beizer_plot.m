function [bin_image] = Beizer_plot(point, type, size)
%Plot the Beizer curve in the binary picture.
%   [bin_image] = Beizer_plot(point, type, size)
%Input:  point : coordinates list of the extreme and control points with
%                size 2 *... with the maximum 1.
%        type  : indicators of each point with size 1 *...
%                1 stands for control point;
%                0 stands for extreme point.
%        size  : the size of the picture to be ploted.
%Output: bin_image: plot the curve in the image.
    bin_image = zeros(size);
    for i = 1:length(point(1,:))
        point(1,i) = floor(point(1,i) * size(1))+1;
        point(2,i) = floor(point(2,i) * size(2))+1;
        if point(1, i) > size(1); point(1, i) = size(1); end
        if point(2, i) > size(2); point(2, i) = size(2); end
    end
    t = point(1,:); point(1,:) = size(2)+1-point(2,:); point(2,:) = t;
    l = length(point(1,:)); i = 1;
    bin_image(point(1,i), point(2,i)) = 1;
    while i < l     
        s = i; i = i + 1;
        while type(i)
            i = i + 1;
        end
        bin_image(point(1,i), point(2,i)) = 1;
        queue = point(1,s:i) + 1j * point(2,s:i);
        n = 0;
        while ~isempty(queue) && n < size(1)*size(2)
            dots = queue(1,:);
            next = zeros(2,i-s+1);
            next(1,1) = dots(1);
            next(2,i-s+1) = dots(i-s+1);
            for t = 1:i-s
                n = length(dots);
                dots = ((dots(1:n-1) + dots(2:n))/2);
                next(1,t+1) = dots(1);
                next(2,i-s+1-t) = dots(n-1);
            end
            next = round(next);
            dots = next(2,1);
            t = length(queue(:,1));
            queue = queue(2:t,:);
            bin_image(real(dots), imag(dots)) = 1;
            if sum(abs(next-dots)) > 0
                queue = [queue;next];
            end
        end
    end
end