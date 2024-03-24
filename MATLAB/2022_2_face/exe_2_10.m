clear all;
load('jpegcodes.mat');
load('hall.mat');
img = hall_gray;
lin_img = img(:)';
code = [];
for i = 1:length(lin_img)
    if(lin_img(i)<0)
         bin = dec2bin(-lin_img(i));
         for l=1:length(bin)
             if(bin(l) =='1')
                 bin(l) = '0';
             else
                 bin(l) = '1';
             end
         end
        binary = bin;
     else
         binary = dec2bin(lin_img(i));
    end
    code = [code,binary];
end
A = length(code);
B = length(DC_code)+length(AC_code)+length(dec2bin(height))+length(dec2bin(width));
A/B

