clear all;
clc;
load('hall.mat');
pic=hall_color;
[length,width,~]=size(hall_color); %求矩阵的维度，inferred：
r1=length/2;
r2=width/2;

for x=1:length
    for y=1:width
        if(((x-r1)^2+(y-r2)^2)<=(length/2)^2)
            pic(x,y,1)=255;
            pic(x,y,2)=0;
            pic(x,y,3)=0;
        end
    end
end
imshow(pic);
imwrite(pic,'exe_1_2_a.png','png');