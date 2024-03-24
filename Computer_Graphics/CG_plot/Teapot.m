close all; clear; clc;
body = [1.4, 1.3375,1.4375,1.5, 1.75, 2,  2,   2,  1.5,  1.5;...
        2.25,2.3815,2.3815,2.25,1.725,1.2,0.75,0.3,0.075,0];
body_type = [0, 1, 1, 0, 0, 1, 0, 1, 1, 0];
lid = [0, 0.8,0,  0.2, 0.4,1.3,1.3;...
       3, 3,  2.7,2.55,2.4,2.4,2.25];
lid_type = [0, 1, 1, 0, 1, 1, 0];
handle_in =  [-1.6, -2.3, -2.7, -2.7,-2.7, -2.5, -2;...
               1.875,1.875,1.875,1.65,1.425,0.975,0.75];
handle_out = [-1.5,-2.5,-3, -3,  -3, -2.65, -1.9;...
               2.1, 2.1, 2.1,1.65,1.2,0.7875,0.45];
handle_type = [0, 0, 1, 0, 1, 1, 0];
spout_in =  [1.7,  2.6,  2.3, 2.7, 2.8,  2.9,  2.8;...
             1.275,1.275,1.95,2.25,2.325,2.325,2.25];
spout_out = [1.7, 3.1,  2.4,  3.3, 3.525,  3.45,  3.2;...
             0.45,0.675,1.875,2.25,2.34375,2.3625,2.25];
spout_type = [0, 1, 1, 0, 1, 1, 0];
%Parameters
phi = 1; theta = -0.3; small = 1;
im_size = [500,500];
Angle_num = 25;

%% Plot in Plane
body_pl = body; body_pl(1,:) = body(1,:) + 4;
lid_pl = lid; lid_pl(1,:) = lid(1,:) + 4;
spout_out_pl = spout_out; spout_out_pl(1,:) = spout_out(1,:) + 4;
spout_in_pl = spout_in; spout_in_pl(1,:) = spout_in(1,:) + 4;
handle_out_pl = handle_out; handle_out_pl(1,:) = handle_out(1,:) + 4;
handle_in_pl = handle_in; handle_in_pl(1,:) = handle_in(1,:) + 4;
bin_img  = Beizer_plot((spout_out_pl)/8,spout_type,im_size);
bin_img  = bin_img | Beizer_plot((spout_in_pl)/8,spout_type,im_size);
bin_img  = bin_img | Beizer_plot((handle_in_pl)/8,handle_type,im_size);
bin_img  = bin_img | Beizer_plot((handle_out_pl)/8,handle_type,im_size);
bin_img  = bin_img | Beizer_plot((lid_pl)/8,lid_type,im_size);
bin_img  = bin_img | Beizer_plot((body_pl)/8,body_type,im_size);
body_pl(1,:) = -body_pl(1,:) + 8; lid_pl(1,:) = -lid_pl(1,:) + 8;
bin_img  = bin_img | Beizer_plot((lid_pl)/8,lid_type,im_size);
bin_img  = bin_img | Beizer_plot((body_pl)/8,body_type,im_size);
figure;imshow(bin_img);

%% Plot the Line
Angle = [0:Angle_num-1]/Angle_num*2*pi;
body3D = zeros(3,length(body_type),Angle_num);
lid3D = zeros(3,length(lid_type),Angle_num);
for i = 1:Angle_num
    body3D(1,:,i) = body(1,:)*cos(Angle(i));
    body3D(2,:,i) = body(2,:);
    body3D(3,:,i) = body(1,:)*sin(Angle(i));
    lid3D(1,:,i) = lid(1,:)*cos(Angle(i));
    lid3D(2,:,i) = lid(2,:);
    lid3D(3,:,i) = lid(1,:)*sin(Angle(i));
end
spout3D = zeros(3,length(spout_type),Angle_num);
spout_centre = [(spout_in + spout_out)/2; zeros(1,length(spout_type))];
handle3D = zeros(3, length(handle_type),Angle_num);
handle_centre = [(handle_in + handle_out)/2; zeros(1,length(handle_type))];
for i = 1:Angle_num
    a = [spout_out;zeros(1,length(spout_type))] - spout_centre;
    r = sqrt(sum(a.^2));
    a = a./repmat(r,3,1);
    b = [-a(2,:);a(1,:);a(3,:)]; 
    spout3D(:,:,i) = [r*cos(Angle(i)); r*sin(Angle(i)); zeros(1,length(spout_type))];
    for j = 1:length(spout_type)
        spout3D(:,j,i) = [a(:,j),[0;0;1],b(:,j)]*spout3D(:,j,i) + spout_centre(:,j);
    end
    
    a = [handle_out;zeros(1,length(handle_type))] - handle_centre;
    r = sqrt(sum(a.^2));
    a = a./repmat(r,3,1);
    b = [-a(2,:);a(1,:);a(3,:)]; 
    handle3D(:,:,i) = [r*cos(Angle(i)); r*sin(Angle(i)); zeros(1,length(handle_type))];
    for j = 1:length(handle_type)
        handle3D(:,j,i) = [a(:,j),[0;0;1],b(:,j)]*handle3D(:,j,i) + handle_centre(:,j);
    end
end

h = 10;
Projection = [h,0, 0,0;...
              0,h, 0,0;...
              0,0,-1,h];
Transformation = [1,0,0,0;...
                  0,cos(phi),-sin(phi),0;...
                  0,sin(phi), cos(phi),0;...
                  0,0,0,1];
Transformation = Transformation * [cos(theta),0,sin(theta),0;...
                                   0,1,0,0;...
                                  -sin(theta),0,cos(theta),0;...
                                   0,0,0,1];
 
body_p = zeros(2, length(body_type), Angle_num);
lid_p = zeros(2, length(lid_type), Angle_num);
spout_p = zeros(2, length(spout_type), Angle_num);
handle_p = zeros(2, length(handle_type), Angle_num);
for i = 1:Angle_num
    vec = Projection * Transformation * [body3D(:,:,i); ones(1,length(body_type))];
    body_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [lid3D(:,:,i); ones(1,length(lid_type))];
    lid_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [handle3D(:,:,i); ones(1,length(handle_type))];
    handle_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [spout3D(:,:,i); ones(1,length(spout_type))];
    spout_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
end
max_b = max(max(max(body_p))); min_b = min(min(min(body_p)));
max_l = max(max(max(lid_p))); min_l = min(min(min(lid_p)));
max_h = max(max(max(handle_p))); min_h = min(min(min(handle_p)));
max_s = max(max(max(spout_p))); min_s = min(min(min(spout_p)));
max1 = max([max_b, max_l, max_h, max_s]); min1 = min([min_b, min_l, min_h, min_s]);
body_p = (body_p - min1+1)/(max1 - min1+1) * small;
lid_p = (lid_p - min1+1)/(max1 - min1+1) * small;
handle_p = (handle_p - min1+1)/(max1 - min1+1) * small;
spout_p = (spout_p - min1+1)/(max1 - min1+1) * small;
bin_img = zeros(im_size);
for i = 1:Angle_num
    bin_img = bin_img | Beizer_plot(body_p(:,:,i),body_type,im_size);
    bin_img = bin_img | Beizer_plot(lid_p(:,:,i),lid_type,im_size);
    bin_img = bin_img | Beizer_plot(handle_p(:,:,i),handle_type,im_size);
    bin_img = bin_img | Beizer_plot(spout_p(:,:,i),spout_type,im_size);
end
for i = 1:length(body_type)
    if ~body_type(i)
        for j = 0:Angle_num-1
            bin_img = bin_img | Line_plot(body_p(:,i,j+1), body_p(:,i,mod(j+1,Angle_num)+1), im_size);
        end
    end
end
for i = 1:length(lid_type)
    if ~lid_type(i)
        for j = 0:Angle_num-1
            bin_img = bin_img | Line_plot(lid_p(:,i,j+1), lid_p(:,i,mod(j+1,Angle_num)+1), im_size);
        end
    end
end
for i = 1:length(handle_type)
    if ~handle_type(i)
        for j = 0:Angle_num-1
            bin_img = bin_img | Line_plot(handle_p(:,i,j+1), handle_p(:,i,mod(j+1,Angle_num)+1), im_size);
        end
    end
end
for i = 1:length(spout_type)
    if ~spout_type(i)
        for j = 0:Angle_num-1
            bin_img = bin_img | Line_plot(spout_p(:,i,j+1), spout_p(:,i,mod(j+1,Angle_num)+1), im_size);
        end
    end
end
figure;imshow(bin_img);

%% Plot the surface
Sample_num = 54;
Angle_point = [0:Angle_num-1]/Angle_num * 2*pi;
k = find(~body_type)-1; body_sample = [];
for j = 1:length(k)-1
    n = k(j+1)-k(j);
    t = [0:((length(body_type)-1)/Sample_num):n] / n;
    s = zeros(3,length(t),Angle_num);
    for x = 0:k(j+1)-k(j)
        tx = nchoosek(n, x)*(1-t).^(n-x).* t.^x;
        s = s + repmat(body3D(:,k(j)+x+1,:),[1,length(t),1]).* repmat(tx,[3 1 Angle_num]);
    end
    body_sample = [body_sample,s(:,1:length(t)-1,:)];
end
k = find(~lid_type)-1; lid_sample = [];
for j = 1:length(k)-1
    n = k(j+1)-k(j);
    t = [0:((length(lid_type)-1)/Sample_num):n] / n;
    s = zeros(3,length(t),Angle_num);
    for x = 0:k(j+1)-k(j)
        tx = nchoosek(n, x)*(1-t).^(n-x).* t.^x;
        s = s + repmat(lid3D(:,k(j)+x+1,:),[1,length(t),1]).* repmat(tx,[3 1 Angle_num]);
    end
    lid_sample = [lid_sample,s(:,1:length(t)-1,:)];
end
k = find(~handle_type)-1; handle_sample = [];
for j = 1:length(k)-1
    n = k(j+1)-k(j);
    t = [0:((length(handle_type)-1)/Sample_num):n] / n;
    s = zeros(3,length(t),Angle_num);
    for x = 0:k(j+1)-k(j)
        tx = nchoosek(n, x)*(1-t).^(n-x).* t.^x;
        s = s + repmat(handle3D(:,k(j)+x+1,:),[1,length(t),1]).* repmat(tx,[3 1 Angle_num]);
    end
    handle_sample = [handle_sample,s(:,1:length(t)-1,:)];
end
k = find(~spout_type)-1; spout_sample = [];
for j = 1:length(k)-1
    n = k(j+1)-k(j);
    t = [0:((length(spout_type)-1)/Sample_num):n] / n;
    s = zeros(3,length(t),Angle_num);
    for x = 0:k(j+1)-k(j)
        tx = nchoosek(n, x)*(1-t).^(n-x).* t.^x;
        s = s + repmat(spout3D(:,k(j)+x+1,:),[1,length(t),1]).* repmat(tx,[3 1 Angle_num]);
    end
    spout_sample = [spout_sample,s(:,1:length(t)-1,:)];
end
gray_img = zeros(im_size.*[8,8]);
z_buff = ones(im_size.*[8,8]) * inf;
body_z = zeros(Sample_num, Angle_num);
body_p = zeros(2, Sample_num, Angle_num);
lid_z = zeros(Sample_num, Angle_num);
lid_p = zeros(2, Sample_num, Angle_num);
handle_z = zeros(Sample_num, Angle_num);
handle_p = zeros(2, Sample_num, Angle_num);
spout_z = zeros(Sample_num, Angle_num);
spout_p = zeros(2, Sample_num, Angle_num);
Ka = 50; Kd = 100; Ks = 100; ns = 3;
for i = 1:Angle_num
    vec = Projection * Transformation * [body_sample(:,:,i); ones(1,Sample_num)];
    body_sample(:,:,i) = Transformation(1:3,1:3) * body_sample(:,:,i);
    body_z(:,i) = vec(3,:);
    body_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [lid_sample(:,:,i); ones(1,Sample_num)];
    lid_sample(:,:,i) = Transformation(1:3,1:3) * lid_sample(:,:,i);
    lid_z(:,i) = vec(3,:);
    lid_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [handle_sample(:,:,i); ones(1,Sample_num)];
    handle_sample(:,:,i) = Transformation(1:3,1:3) * handle_sample(:,:,i);
    handle_z(:,i) = vec(3,:);
    handle_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
    vec = Projection * Transformation * [spout_sample(:,:,i); ones(1,Sample_num)];
    spout_sample(:,:,i) = Transformation(1:3,1:3) * spout_sample(:,:,i);
    spout_z(:,i) = vec(3,:);
    spout_p(:,:,i) = [vec(1,:)./vec(3,:); vec(2,:)./vec(3,:)];
end
for i = 1:Angle_num
    for j = 1:Sample_num
        body_p(:,j,i) = floor(body_p(:,j,i).*im_size') + [1500; 1500];
        lid_p(:,j,i) = floor(lid_p(:,j,i).*im_size') + [1500; 1500];
        handle_p(:,j,i) = floor(handle_p(:,j,i).*im_size') + [1500; 1500];
        spout_p(:,j,i) = floor(spout_p(:,j,i).*im_size') + [1500; 1500];
    end
end
[gray_img, z_buff] = surf_phong(body_p, body_sample, body_z, gray_img, z_buff, Ka, Kd, Ks, ns);
[gray_img, z_buff] = surf_phong(lid_p, lid_sample, lid_z, gray_img, z_buff, Ka, Kd, Ks, ns);
[gray_img, z_buff] = surf_phong(handle_p, handle_sample, handle_z, gray_img, z_buff, Ka, Kd, Ks, ns);
[gray_img, z_buff] = surf_phong(spout_p, spout_sample, spout_z, gray_img, z_buff, Ka, Kd, Ks, ns);
figure; imshow(uint8(rot90(gray_img',2)));

%% Print decoration
flower = rgb2gray(imread('Flower.jpg'));
flower = double(rot90(flower,2));
f_size = size(flower);
for i = floor(Angle_num/8):ceil(3*Angle_num/8)
    for j = floor(Sample_num/3)+1:Sample_num-2
        a = body_p(:,j,i+1);
        b = body_p(:,j,mod(i+1,Angle_num)+1);
        c = body_p(:,j+1,i+1);
        d = body_p(:,j+1,mod(i+1,Angle_num)+1);
        interior = [Triangle_patch(a, b, d), Triangle_patch(a, c, d)];
        za = body_z(j,i+1); zb = body_z(j,mod(i+1,Angle_num)+1);
        zc = body_z(j+1,i+1); zd = body_z(j+1,mod(i+1,Angle_num)+1);
        Z = [za, zb, zc, zd];
        X = [i+1,i+2,i+1,i+2;...
               j,  j,j+1,j+1];
        A = [[a,b,c,d]',ones(4,1)];
        K1 = A \ Z'; K2 = A \ X';
        for k = 1:length(interior)
            if interior(1,k) <=0 || interior(1,k) > size(gray_img,1) ||...
               interior(2,k) <=0 || interior(2,k) > size(gray_img,2)
                continue;
            end
            K = K2'*[interior(:,k);1];
            x = (K(1)-floor(Angle_num/8)) / (ceil(3*Angle_num/8)-floor(Angle_num/8)) * f_size(1);
            y = (K(2)-floor(Sample_num/3)) / (Sample_num*2/3) * f_size(2);
            z = K1'*[interior(:,k);1];
            if abs(z_buff(interior(1,k),interior(2,k))- z) < 0.1
                gray_img(interior(1,k),interior(2,k)) = gray_img(interior(1,k),interior(2,k)) *...
                                                        bilinear_interpolation(flower, x, y)/255;
            end
        end
    end
end
figure; imshow(uint8(rot90(gray_img',2)));
