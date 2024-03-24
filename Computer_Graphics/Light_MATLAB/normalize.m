function norm = normalize(X, Y, Z)

    % 输入X、Y、Z应为网格格式
    % 输出为单位法向量

    m = size(X);
    n = m(2);
    m = m(1);

    x1 = X(2:m, :) - X(1:m-1, :);
    y1 = Y(2:m, :) - Y(1:m-1, :);
    z1 = Z(2:m, :) - Z(1:m-1, :);
    x2 = X(:, 2:n) - X(:, 1:n-1);
    y2 = Y(:, 2:n) - Y(:, 1:n-1);
    z2 = Z(:, 2:n) - Z(:, 1:n-1);

    x1 = [x1; x1(m-1, :)];
    y1 = [y1; y1(m-1, :)];
    z1 = [z1; z1(m-1, :)];
    x2 = [x2, x2(:, n-1)];
    y2 = [y2, y2(:, n-1)];
    z2 = [z2, z2(:, n-1)];

    x1 = reshape(x1, numel(x1), 1);
    y1 = reshape(y1, numel(y1), 1);
    z1 = reshape(z1, numel(z1), 1);
    x2 = reshape(x2, numel(x2), 1);
    y2 = reshape(y2, numel(y2), 1);
    z2 = reshape(z2, numel(z2), 1);

    point1 = [x1, y1, z1];
    point2 = [x2, y2, z2];
    norm = zeros(numel(x1), 3);
    for xx = 1 : numel(x1)
        norm(xx, :) = cross(point1(xx, :), point2(xx, :));
    end
    norm = norm ./ sqrt(norm(:, 1).^2 + norm(:, 2).^2 + norm(:, 3).^2);

end