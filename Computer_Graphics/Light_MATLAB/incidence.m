function [out, r] = incidence(X, Y, Z, O)

    % 输入X、Y、Z应为网格格式。O为光源坐标。
    % 输出out每行为一个坐标，r为距离的平方

    x_incidence = X - O(1);
    y_incidence = Y - O(2);
    z_incidence = Z - O(3);
    r = x_incidence.^2 + y_incidence.^2 + z_incidence.^2;
    x_incidence = reshape(x_incidence ./ sqrt(r), numel(X), 1);
    y_incidence = reshape(y_incidence ./ sqrt(r), numel(Y), 1);
    z_incidence = reshape(z_incidence ./ sqrt(r), numel(Z), 1);
    r = reshape(r, numel(r), 1);
    out = [x_incidence, y_incidence, z_incidence];

end