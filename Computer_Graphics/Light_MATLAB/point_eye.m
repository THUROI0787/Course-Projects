function [out, r] = point_eye(X, Y, Z, eye)

    % 输入X、Y、Z应为网格格式。O为光源坐标。
    % 输出out每行为一个坐标，r为距离的平方

    x_eye = eye(1) - X;
    y_eye = eye(2) - Y;
    z_eye = eye(3) - Z;
    r = x_eye.^2 + y_eye.^2 + z_eye.^2;
    x_eye = reshape(x_eye ./ sqrt(r), numel(X), 1);
    y_eye = reshape(y_eye ./ sqrt(r), numel(Y), 1);
    z_eye = reshape(z_eye ./ sqrt(r), numel(Z), 1);
    r = reshape(r, numel(r), 1);
    out = [x_eye, y_eye, z_eye];

end