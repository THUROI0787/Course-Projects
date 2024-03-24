function hsi=rgb2hsi(rgb)
% RGB to HSI
rgb = im2double(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);
theta=acos(0.5*((r-g)+(r-b))./(((r-g).^2+(r-b).*(g-b)).^0.5+eps));
hsi(:,:,1)=(theta.*(b<g+(b==g))+(2*pi-theta).*(b>g))/(2*pi);
hsi(:,:,2)=1-3*(min(min(r,g),b))./(r+g+b+eps);
hsi(:,:,3)=(r+g+b)/3;