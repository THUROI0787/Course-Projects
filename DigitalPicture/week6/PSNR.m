function PSNR = PSNR(pic1, pic2)
k = 8;  % kÎªÎ»Éî
fmax = 2.^k - 1;
a = fmax.^2;
MSE =(double(im2uint8(pic1)) -double( im2uint8(pic2))).^2;
b = mean(mean(MSE));
PSNR = 10*log10(a/b);
