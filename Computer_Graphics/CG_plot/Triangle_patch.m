function [interior] = Triangle_patch(a, b, c)
%Return the points list indicating interior of the Triangle 
%       with extreme point a, b, c
    if b(2) <= a(2) && b(2) <= c(2)
        t = b; b = a; a = t;
    elseif c(2) <= a(2) && c(2) <= b(2)
        t = c; c = a; a = t;
    end
    interior = a;
    dx_l = b(1) - a(1); dy_l = b(2) - a(2);
    dx_r = c(1) - a(1); dy_r = c(2) - a(2);
    if dx_l * dy_r == dx_r * dy_l; return;
    elseif dx_l * dy_r > dx_r * dy_l
        t = c; c = b; b = t;
        dx_l = b(1) - a(1); dy_l = b(2) - a(2);
        dx_r = c(1) - a(1); dy_r = c(2) - a(2);
    end
    y = a(2); x_l = a(1); x_r = a(1);
    if dx_l > 0; step_xl = 1; else step_xl = -1; dx_l = -dx_l; end
    if dx_r > 0; step_xr = 1; else step_xr = -1; dx_r = -dx_r; end
    if dx_l > dy_l; pl = 2*dy_l - dx_l; else pl = 2*dx_l - dy_l; end
    if dx_r > dy_r; pr = 2*dy_r - dx_r; else pr = 2*dx_r - dy_r; end
    while 1
        if dx_l > dy_l
            while pl < 0
                if (x_l == b(1) && y == b(2)); break; end
                x_l = x_l + step_xl;
                pl = 2 * dy_l + pl;
            end
            x_ln = x_l + step_xl; pl = 2 * (dy_l - dx_l) + pl;
        else
            if pl < 0; pl = 2 * dx_l + pl; x_ln = x_l;
            else x_ln = x_l + step_xl; pl = 2 * (dx_l - dy_l) + pl;
            end
        end
        if dx_r > dy_r
            while pr < 0
                if (x_r == c(1) && y == c(2)); break; end
                x_r = x_r + step_xr;
                pr = 2 * dy_r + pr;
            end
            x_rn = x_r + step_xr; pr = 2 * (dy_r - dx_r) + pr;
        else
            if pr < 0; pr = 2 * dx_r + pr; x_rn = x_r;
            else x_rn = x_r + step_xr; pr = 2 * (dx_r - dy_r) + pr;
            end
        end
        for x = x_l:x_r
            if isempty(find(interior(1,:)==x & interior(2,:)==y, 1))
                interior = [interior,[x;y]];
            end
        end
        if (x_l == b(1) && y == b(2)) || (x_r == c(1) && y == c(2)); break; end
        y = y + 1; x_l = x_ln; x_r = x_rn;
    end
    if (x_l == b(1) && y == b(2)) && (x_r == c(1) && y == c(2)); return;
    elseif (x_l == b(1) && y == b(2))
        dx_l = c(1) - b(1); dy_l = c(2) - b(2);  ED = c;
        if dx_l > 0; step_xl = 1; else step_xl = -1; dx_l = -dx_l; end
        if dx_l > dy_l; pl = 2*dy_l - dx_l; else pl = 2*dx_l - dy_l; end
        if dx_l > dy_l
            while pl < 0
                if (x_l == ED(1) && y == ED(2)); break; end
                x_l = x_l + step_xl;
                pl = 2 * dy_l + pl;
            end
            x_l = x_l + step_xl; pl = 2 * (dy_l - dx_l) + pl;
        else
            if pl < 0; pl = 2 * dx_l + pl;
            else x_l = x_l + step_xl; pl = 2 * (dx_l - dy_l) + pl;
            end
        end
        y = y + 1;
    else
        dx_r = b(1) - c(1); dy_r = b(2) - c(2); ED = b;
        if dx_r > 0; step_xr = 1; else step_xr = -1; dx_r = -dx_r; end
        if dx_r > dy_r; pr = 2*dy_r - dx_r; else pr = 2*dx_r - dy_r; end
        y = y + 1;
        if dx_r > dy_r
            while pr < 0
                if (x_r == ED(1) && y == ED(2)); break; end
                x_r = x_r + step_xr;
                pr = 2 * dy_r + pr;
            end
            x_r = x_r + step_xr; pr = 2 * (dy_r - dx_r) + pr;
        else
            if pr < 0; pr = 2 * dx_r + pr;
            else x_r = x_r + step_xr; pr = 2 * (dx_r - dy_r) + pr;
            end
        end
    end
    while 1
        if dx_l > dy_l
            while pl < 0
                if (x_l == ED(1) && y == ED(2)); break; end
                x_l = x_l + step_xl;
                pl = 2 * dy_l + pl;
            end
            x_ln = x_l + step_xl; pl = 2 * (dy_l - dx_l) + pl;
        else
            if pl < 0; pl = 2 * dx_l + pl; x_ln = x_l;
            else x_ln = x_l + step_xl; pl = 2 * (dx_l - dy_l) + pl;
            end
        end
        if dx_r > dy_r
            while pr < 0
                if (x_r == ED(1) && y == ED(2)); break; end
                x_r = x_r + step_xr;
                pr = 2 * dy_r + pr;
            end
            x_rn = x_r + step_xr; pr = 2 * (dy_r - dx_r) + pr;
        else
            if pr < 0; pr = 2 * dx_r + pr; x_rn = x_r;
            else x_rn = x_r + step_xr; pr = 2 * (dx_r - dy_r) + pr;
            end
        end
        for x = x_l:x_r
            if isempty(find(interior(1,:)==x & interior(2,:)==y, 1))
                interior = [interior, [x;y]];
            end
        end
        if (x_r == ED(1) && y == ED(2)) || (x_l == ED(1) && y == ED(2)); break; end
        y = y + 1; x_l = x_ln; x_r = x_rn;
    end
end

