function out = randomback_plus(X, Y, Z, C, norm, ambient, diffuse, reflect, range, eye, N, M)

    % X，Y，Z是相同大小的矩阵，同位置参数分别为一个点的三个坐标
    % C为明亮度矩阵
    % norm为每个点的法向量，每一竖相连
    % ambient为环境光参数，为漫散射光参数，为镜面反射光参数
    % range为迭代点范围，格式3*2
    % eye为视角点坐标
    % N为迭代次数
    % M为变异范围

    number = 30;        % 迭代点个数
    sample = 10;         % 抽样间隔

    % 随机产生点，并进行点的格式重整
    x0 = range(1, 1) + (range(1, 2) - range(1, 1)) * rand(1, number);
    y0 = range(2, 1) + (range(2, 2) - range(2, 1)) * rand(1, number);
    z0 = range(3, 1) + (range(3, 2) - range(3, 1)) * rand(1, number);
    x1 = zeros(1, number);
    y1 = zeros(1, number);
    z1 = zeros(1, number);
    X = reshape(X, numel(X), 1);
    Y = reshape(Y, numel(Y), 1);
    Z = reshape(Z, numel(Z), 1);
    C = reshape(C, numel(C), 1);
    loss = [];

    % 预处理
    X = X(1: sample: numel(X));
    Y = Y(1: sample: numel(Y));
    Z = Z(1: sample: numel(Z));
    C = C(1: sample: numel(C));
    norm_x = size(norm);
    norm_x = norm_x(1);
    norm = norm(1: sample: norm_x, :);    

    % 视角
    [eye1, R] = point_eye(X, Y, Z, eye);
    % 先产生初始的点
    for xx = 1 : 16
        % 入射光
        [point_incidence, r] = incidence(X, Y, Z, [x0(xx), y0(xx), z0(xx)]);
        % 反射光
        lamber = max(sum(-point_incidence.*norm, 2), 0);
        point_reflect = point_incidence + 2 * lamber .* norm;
        for yy = 1 : numel(X)
            if lamber(yy) == 0
                point_reflect(yy, :) = [0, 0, 0];
            end
        end
        % 计算模拟点光强和实际光均方误差
        r_all = (sqrt(R) + sqrt(r)).^2;
        color = ambient + diffuse * min(r_all)* lamber ./ r_all + reflect * max(sum(eye1 .* point_reflect, 2), 0) * min(r_all) ./ r_all;
        loss = [loss, sum(abs(color-C))];
    end

    % 对初始的点进行遗传变异，并开展迭代
    for nn = 1 : N
        for xx = 17 : number
            % 入射光
            [point_incidence, r] = incidence(X, Y, Z, [x0(xx), y0(xx), z0(xx)]);
            % 反射光
            lamber = max(sum(-point_incidence.*norm, 2), 0);
            point_reflect = point_incidence + 2 * lamber .* norm;
            for yy = 1 : numel(X)
                if lamber(yy) == 0
                    point_reflect(yy, :) = [0, 0, 0];
                end
            end
            % 计算模拟点光强和实际光均方误差
            r_all = (sqrt(R) + sqrt(r)).^2;
            color = ambient + diffuse * min(r_all) * lamber ./ r_all + reflect * max(sum(eye1 .* point_reflect, 2), 0) * min(r_all) ./ r_all;
            loss = [loss, sum(abs(color-C))];
        end
        % 选出最佳的几个点
        [value, loc] = sort(loss, 2, 'ascend');
        loss= [];
        for xx = 1 : 16
            x1(xx) = x0(loc(xx));
            y1(xx) = y0(loc(xx));
            z1(xx) = z0(loc(xx));
            loss = [loss, value(xx)];
        end
        % 遗传
        k = 17;
        for xx = 1 : 4
            for yy = xx+1 : 4
                x1(k) = (x1(xx) + x1(yy)) / 2;
                y1(k) = (y1(xx) + y1(yy)) / 2;
                z1(k) = (z1(xx) + z1(yy)) / 2;
                k = k + 1;
            end
        end
        % 变异
        for xx = 1 : 4
            for yy = 1 : 2
                x1(k) = min(max(x1(xx) + M*(2*rand(1, 1) - 1), range(1, 1)), range(1, 2));
                y1(k) = min(max(y1(xx) + M*(2*rand(1, 1) - 1), range(2, 1)), range(2, 2));
                z1(k) = min(max(z1(xx) + M*(2*rand(1, 1) - 1), range(3, 1)), range(3, 2));
                k = k + 1;
            end
        end
        x0 = x1;
        y0 = y1;
        z0 = z1;
    end

    out = [x0(1), y0(1), z0(1)];
end