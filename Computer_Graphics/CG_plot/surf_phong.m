function [gray_img, z_buff] = surf_phong(body_p, body_sample, body_z, gray_img, z_buff, Ka, Kd, Ks, ns)
    s = size(body_p);
    Angle_num = s(3); Sample_num = s(2);
    for i = 0:Angle_num-1
        j = 1;
        a = body_p(:,j,i+1); b = body_p(:,j,mod(i+1,Angle_num)+1);
        c = body_p(:,j+1,i+1); d = body_p(:,j+1,mod(i+1,Angle_num)+1);
        interior = [Triangle_patch(a, b, d), Triangle_patch(a, c, d)];
        za = body_z(j,i+1); zb = body_z(j,mod(i+1,Angle_num)+1);
        zc = body_z(j+1,i+1); zd = body_z(j+1,mod(i+1,Angle_num)+1);
        na = 2 * (cross(body_sample(:,j,mod(i-1,Angle_num)+1)-body_sample(:,j,i+1), body_sample(:,j+1,i+1)-body_sample(:,j,i+1)) + ...
                  cross(body_sample(:,j+1,i+1)-body_sample(:,j,i+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j,i+1)));
        nb = 2 * (cross(body_sample(:,j,i+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+2,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)));
        nc = (cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j+1,i+1), body_sample(:,j,i+1)-body_sample(:,j+1,i+1)) + ...
              cross(body_sample(:,j,i+1)-body_sample(:,j+1,i+1), body_sample(:,j+1,mod(i-1,Angle_num)+1)-body_sample(:,j+1,i+1)) + ...
              cross(body_sample(:,j+1,mod(i-1,Angle_num)+1)-body_sample(:,j+1,i+1), body_sample(:,j+2,i+1)-body_sample(:,j+1,i+1)) + ...
              cross(body_sample(:,j+2,i+1)-body_sample(:,j+1,i+1), body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j+1,i+1)));
        nd = (cross(body_sample(:,j+1,mod(i+2,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+1,i+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j+1,i+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+2,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j+2,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+1,mod(i+2,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)));
        Y = [na, nb, nc, nd; za, zb, zc, zd]'; A = [[a,b,c,d]',ones(4,1)]; X = A \ Y;
        for k = 1:length(interior)
            if interior(1,k) <=0 || interior(1,k) > size(gray_img,1) ||...
               interior(2,k) <=0 || interior(2,k) > size(gray_img,2)
                continue;
            end
            n = X'*[interior(:,k);1]; in = [(interior(:,k)'-1000)/5000, 1];
            cos = abs(in * n(1:3))/sqrt(sum(in.^2)*sum(n(1:3).^2));
            if z_buff(interior(1,k),interior(2,k)) > n(4)
                gray_img(interior(1,k),interior(2,k)) = round(Ka + Kd * cos + Ks * cos^ns);
                z_buff(interior(1,k),interior(2,k)) = n(4);
            end
        end
        for j = 2:Sample_num-2
            a = body_p(:,j,i+1);
            b = body_p(:,j,mod(i+1,Angle_num)+1);
            c = body_p(:,j+1,i+1);
            d = body_p(:,j+1,mod(i+1,Angle_num)+1);
            interior = [Triangle_patch(a, b, d), Triangle_patch(a, c, d)];
            za = body_z(j,i+1); zb = body_z(j,mod(i+1,Angle_num)+1);
            zc = body_z(j+1,i+1); zd = body_z(j+1,mod(i+1,Angle_num)+1);
            na = (cross(body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j,i+1), body_sample(:,j-1,i+1)-body_sample(:,j,i+1)) + ...
                  cross(body_sample(:,j-1,i+1)-body_sample(:,j,i+1), body_sample(:,j,mod(i-1,Angle_num)+1)-body_sample(:,j,i+1)) + ...
                  cross(body_sample(:,j,mod(i-1,Angle_num)+1)-body_sample(:,j,i+1), body_sample(:,j+1,i+1)-body_sample(:,j,i+1)) + ...
                  cross(body_sample(:,j+1,i+1)-body_sample(:,j,i+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j,i+1)));
            nb = (cross(body_sample(:,j,mod(i+2,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j-1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j-1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j,i+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j,i+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+2,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)));
            nc = (cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j+1,i+1), body_sample(:,j,i+1)-body_sample(:,j+1,i+1)) + ...
                  cross(body_sample(:,j,i+1)-body_sample(:,j+1,i+1), body_sample(:,j+1,mod(i-1,Angle_num)+1)-body_sample(:,j+1,i+1)) + ...
                  cross(body_sample(:,j+1,mod(i-1,Angle_num)+1)-body_sample(:,j+1,i+1), body_sample(:,j+2,i+1)-body_sample(:,j+1,i+1)) + ...
                  cross(body_sample(:,j+2,i+1)-body_sample(:,j+1,i+1), body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j+1,i+1)));
            nd = (cross(body_sample(:,j+1,mod(i+2,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+1,i+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j+1,i+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+2,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j+2,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+1,mod(i+2,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)));
            Y = [na, nb, nc, nd; za, zb, zc, zd]'; A = [[a,b,c,d]',ones(4,1)]; X = A \ Y;
            for k = 1:length(interior)
                if interior(1,k) <=0 || interior(1,k) > size(gray_img,1) ||...
                   interior(2,k) <=0 || interior(2,k) > size(gray_img,2)
                    continue;
                end
                n = X'*[interior(:,k);1]; in = [(interior(:,k)'-1000)/5000, 1];
                cos = abs(in * n(1:3))/sqrt(sum(in.^2)*sum(n(1:3).^2));
                if z_buff(interior(1,k),interior(2,k)) > n(4)
                    gray_img(interior(1,k),interior(2,k)) = round(Ka + Kd * cos + Ks * cos^ns);
                    z_buff(interior(1,k),interior(2,k)) = n(4);
                end
            end
        end
        j = Sample_num - 1;
        a = body_p(:,j,i+1); b = body_p(:,j,mod(i+1,Angle_num)+1);
        c = body_p(:,j+1,i+1); d = body_p(:,j+1,mod(i+1,Angle_num)+1);
        interior = [Triangle_patch(a, b, d), Triangle_patch(a, c, d)];
        za = body_z(j,i+1); zb = body_z(j,mod(i+1,Angle_num)+1);
        zc = body_z(j+1,i+1); zd = body_z(j+1,mod(i+1,Angle_num)+1);
        na = (cross(body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j,i+1), body_sample(:,j-1,i+1)-body_sample(:,j,i+1)) + ...
              cross(body_sample(:,j-1,i+1)-body_sample(:,j,i+1), body_sample(:,j,mod(i-1,Angle_num)+1)-body_sample(:,j,i+1)) + ...
              cross(body_sample(:,j,mod(i-1,Angle_num)+1)-body_sample(:,j,i+1), body_sample(:,j+1,i+1)-body_sample(:,j,i+1)) + ...
              cross(body_sample(:,j+1,i+1)-body_sample(:,j,i+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j,i+1)));
        nb = (cross(body_sample(:,j,mod(i+2,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j-1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j-1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j,i+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j,i+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)) + ...
              cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+2,Angle_num)+1)-body_sample(:,j,mod(i+1,Angle_num)+1)));
        nc = 2 * (cross(body_sample(:,j+1,mod(i+1,Angle_num)+1)-body_sample(:,j+1,i+1), body_sample(:,j,i+1)-body_sample(:,j+1,i+1)) + ...
                  cross(body_sample(:,j,i+1)-body_sample(:,j+1,i+1), body_sample(:,j+1,mod(i-1,Angle_num)+1)-body_sample(:,j+1,i+1)));
        nd = 2 * (cross(body_sample(:,j+1,mod(i+2,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)) + ...
                  cross(body_sample(:,j,mod(i+1,Angle_num)+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1), body_sample(:,j+1,i+1)-body_sample(:,j+1,mod(i+1,Angle_num)+1)));
        Y = [na, nb, nc, nd; za, zb, zc, zd]'; A = [[a,b,c,d]',ones(4,1)]; X = A \ Y;
        for k = 1:length(interior)
            if interior(1,k) <=0 || interior(1,k) > size(gray_img,1) ||...
               interior(2,k) <=0 || interior(2,k) > size(gray_img,2)
                continue;
            end
            n = X'*[interior(:,k);1]; in = [(interior(:,k)'-1000)/5000, 1];
            cos = abs(in * n(1:3))/sqrt(sum(in.^2)*sum(n(1:3).^2));
            if z_buff(interior(1,k),interior(2,k)) > n(4)
                gray_img(interior(1,k),interior(2,k)) = round(Ka + Kd * cos + Ks * cos^ns);
                z_buff(interior(1,k),interior(2,k)) = n(4);
            end
        end
    end
end