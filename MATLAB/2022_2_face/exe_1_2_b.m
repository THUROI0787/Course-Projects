%
clear all;
clc;
load('hall.mat');
[length,width,~]=size(hall_color);
pic=hall_color;
for x=1:length
    for y=1:width
        if(mod(fix((x-1)/4)+fix((y-1)/4),2)==0)
            pic(x,y,1)=0;
            pic(x,y,2)=0;
            pic(x,y,3)=0;
        end
    end
end
imshow(pic);
imwrite(pic,'exe_1_2_b.png','png');