clc;clear;close all;

% 参数
O = [0, 2, 2];           % 白色点光源坐标
eye = [1, 1, 1];        % 观察点坐标
ambient = 0.05;     % phong参数
diffuse = 0.7;
reflect = 0.1;
blinn = 1 - ambient - diffuse - reflect;    % blinn参数


% ————黑白物体——————————————

% ————生成物体1——————
% 球
X=[-1: 0.001: 1];
Y = X;
[X,Y] = meshgrid(X,Y);
Z1 = 1-X.^2-Y.^2;
Z1(Z1<0) = 0;
Z1 = sqrt(Z1);

% 求取视角单位向量
[eye1, R1] = point_eye(X, Y, Z1, eye);

% 求取单位入射向量
[point_incidence1, r1] = incidence(X, Y, Z1, O);

% 半角
half_angle1 = (eye1 - point_incidence1) ./ sqrt(sum((eye1 -point_incidence1).^2 , 2));

% 求单位法向量
norm1 = -normalize(X, Y, Z1);

% 求单位反射向量，并进行光照
lamber1 = max(sum(-point_incidence1.*norm1, 2), 0);
point_reflect1 = point_incidence1 + 2 * lamber1 .* norm1;
for xx = 1 : numel(X)
    if lamber1(xx) == 0
        point_reflect1(xx, :) = [0, 0, 0];
    end
end
r_all1 = (sqrt(r1) + sqrt(R1)).^2;
color1 = ambient + diffuse * min(r_all1) * lamber1 ./ r_all1 + reflect * max(sum(eye1.*point_reflect1, 2), 0) * min(r_all1) ./ r_all1 + blinn * max(sum(half_angle1.*norm1, 2), 0) * min(r_all1) ./ r_all1;
size_X = size(X);
color1_1 = reshape(color1, size_X(1), size_X(2));
C1_1(:, :, 1) = color1_1;
C1_1(:, :, 2) = color1_1;
C1_1(:, :, 3) = color1_1;

% 作图
figure( 'color', 'black');
hold on;
surf(X, Y, Z1, C1_1);
shading flat;
view(eye);
axis off;

% ————生成物体2——————
Z2 = Y - 1;
Y2 = zeros(size(Y)) + 1;
% 求视角
[eye2, R2] = point_eye(X, Y2, Z2, eye);
% 求取单位入射向量
[point_incidence2, r2] = incidence(X, Y2, Z2, O);
% 半角
half_angle2 = (eye2 - point_incidence2) ./ sqrt(sum((eye2 -point_incidence2).^2 , 2));
% 求单位法向量
norm2 = normalize(X, Y2, Z2);
% 求单位反射向量，并进行光照
lamber2 = max(sum(-point_incidence2.*norm2, 2), 0);
point_reflect2 = point_incidence2 + 2 * lamber2 .* norm2;
for xx = 1 : numel(X)
    if lamber2(xx) == 0
        point_reflect2(xx, :) = [0, 0, 0];
    end
end
r_all2 = (sqrt(r2) + sqrt(R2)).^2;
color2 = ambient + diffuse * min(r_all2) * lamber2 ./ r_all2 + reflect * max(sum(eye2.*point_reflect2, 2), 0) * min(r_all2) ./ r_all2 + blinn * max(sum(half_angle2.*norm2, 2), 0) * min(r_all2) ./ r_all2;
color2_1 = reshape(color2, size_X(1), size_X(2));
C2_1(:, :, 1) = color2_1;
C2_1(:, :, 2) = color2_1;
C2_1(:, :, 3) = color2_1;
surf(X, Y2, Z2, C2_1);
shading flat;
view(eye);
axis off;

Z3 = X - 1;
X3 = zeros(size(Y)) + 1;
% 求视角
[eye3, R3] = point_eye(X3, Y, Z3, eye);
% 求取单位入射向量
[point_incidence3, r3] = incidence(X3, Y, Z3, O);
% 半角
half_angle3 = (eye3 - point_incidence3) ./ sqrt(sum((eye3 -point_incidence3).^2 , 2));
% 求单位法向量
norm3 = normalize(X3, Y, Z3);
% 求单位反射向量，并进行光照
lamber3 = max(sum(-point_incidence3.*norm3, 2), 0);
point_reflect3 = point_incidence3 + 2 * lamber3 .* norm3;
for xx = 1 : numel(X)
    if lamber3(xx) == 0
        point_reflect3(xx, :) = [0, 0, 0];
    end
end
r_all3 = (sqrt(r3) + sqrt(R3)).^2;
color3 = ambient + diffuse * min(r_all3) * lamber3 ./ r_all3 + reflect * max(sum(eye3.*point_reflect3, 2), 0) * min(r_all3) ./ r_all3 + blinn * max(sum(half_angle3.*norm3, 2), 0) * min(r_all3) ./ r_all3;
color3_1 = reshape(color3, size_X(1), size_X(2));
C3_1(:, :, 1) = color3_1;
C3_1(:, :, 2) = color3_1;
C3_1(:, :, 3) = color3_1;
surf(X3, Y, Z3, C3_1);
shading flat;
view(eye);
axis off;