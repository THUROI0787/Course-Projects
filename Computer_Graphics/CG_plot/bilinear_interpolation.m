function pixel = bilinear_interpolation(pic, i, j)
% Input:
%     pic   : Image in 2-dim Matrix bigger than 3 * 3.
%     i, j  : Float coordinates of the required pixel within 1 ~ size(pic).
% Ouptut:
%     pixel : Linear interpolation of the image to get the pixel,
%             using  Axy + Bx + Cy + D
    s = size(pic);
    x = [floor(i), ceil(i)]; y = [floor(j), ceil(j)];
    if x(1) < 1; x(1) = 1; elseif x(1) > s(1); x(1) = s(1); end
    if x(2) < 1; x(2) = 1; elseif x(2) > s(1); x(2) = s(1); end
    if y(1) < 1; y(1) = 1; elseif y(1) > s(2); y(1) = s(2); end
    if y(2) < 1; y(2) = 1; elseif y(2) > s(2); y(2) = s(2); end
    pixel = pic(x(1),y(1));return;
    T = [x(1)*y(1), x(1), y(1), 1;...
         x(2)*y(2), x(2), y(2), 1;...
         x(1)*y(2), x(1), y(2), 1;...
         x(2)*y(1), x(2), y(1), 1];
    b = [pic(x(1),y(1)); pic(x(2),y(2)); pic(x(1),y(2)); pic(x(2), y(1))];
    X = T \ double(b);
    pixel = round(X(1)*i*j + X(2)*i + X(3)*j + X(4));
end