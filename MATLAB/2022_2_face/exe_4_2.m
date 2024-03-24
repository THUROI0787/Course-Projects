%
clear all;
close all;
clc;
%(L,d_stan,flit,block_noise)
%(3,0.6,1,23)
%(4,0.685,1,12)
%(5,0.82,2,10)
L=5; %3 4 5
d_stan=0.82; 
flit=2;%the round of fliter
block_noise=10;
load('exe_4_1.mat'); %v3 v4 v5
if(L==3)
    v=v3;
elseif(L==4)
    v=v4;
else
    v=v5;
end
block_leng=36; %1008=16*7*9 %not for all %会不会导致红线太粗?
line_leng=6; %drew red line
freq=zeros(2^(3*L),1);
file=strcat('Faces\test.jpg');
pic=double(imread(file,'jpg'));
[leng,width,~]=size(pic);
block_err=zeros(leng/block_leng,width/block_leng); %3024*4032/(block_leng^2),1 for yep,0 for nope
%% %judge
for a=1:(leng/block_leng)
    for b=1:(width/block_leng)
        block_num=a*(width/block_leng)+b; %the order of current block
        pic_block=pic((a-1)*block_leng+1:a*block_leng,(b-1)*block_leng+1:b*block_leng,:);
        for c=1:block_leng
            for d=1:block_leng
                R=pic_block(c,d,1); %8bits 0~255
                G=pic_block(c,d,2);
                B=pic_block(c,d,3);
                num=fix(R/(2^(8-L)))*2^(2*L)+fix(G/(2^(8-L)))*2^L+fix(B/(2^(8-L)));%通过除法实现映射关系
                freq(num+1)=freq(num+1)+1; %从1开始算
            end
        end
        freq=freq/(block_leng^2);
        d=1-sum(sqrt(v).*sqrt(freq));
        if(d<d_stan)
            block_err(a,b)=1;
        end
    end
end
%% %fliter
%这里是否可以引入参数x表示均值滤波的次数？对于1比0少的图 滤波过后1一定会继续减少吗？
%此处均值滤波就是中值滤波
%别的滤波算法？
%目的不只是去除噪点，还有去除狭长的噪声，避免在下一步因为合成被放大
for x=1:flit
    for a=2:leng/block_leng-1
        for b=2:width/block_leng-1
            area=block_err(a-1:a+1,b-1:b+1);
            block_err(a,b)=round(mean(area(1:9)));
        end
    end
end
%% %area
[L,num]=bwlabel(block_err,8);
area_red=zeros(num,2,2); %记录上下左右四个边界(num,1,:)是x起止,(num,2,:)是y起止
flag=zeros(num);
for a=1:num
    area_x=[];
    area_y=[];
    for b=1:leng/block_leng
        for c=1:width/block_leng
            if(L(b,c)==a)
                flag(a)=flag(a)+1;
                area_x=[area_x,b];
                area_y=[area_y,c];
            end
        end
    end
    if (flag(a)<=block_noise) %手动滤波
        flag(a)=0;
    end
    area_red(a,1,1)=min(area_x);
    area_red(a,1,2)=max(area_x);
    area_red(a,2,1)=min(area_y);
    area_red(a,2,2)=max(area_y);
end
%% %red line
pic_red1=zeros(line_leng,block_leng,3);
pic_red1(:,:,1)=255;
pic_red1(:,:,2)=0;
pic_red1(:,:,3)=0;
pic_red2=zeros(block_leng,line_leng,3);
pic_red2(:,:,1)=255;
pic_red2(:,:,2)=0;
pic_red2(:,:,3)=0;
for a=1:(leng/block_leng)
    for b=1:(width/block_leng)
        up=0;down=0;left=0;right=0;
        for c=1:num
            if (flag(c)~=0)
                if((a==area_red(c,1,1))&&(b>=area_red(c,2,1))&&(b<=area_red(c,2,2))) %up
                    pic((a-1)*block_leng+1:(a-1)*block_leng+line_leng,(b-1)*block_leng+1:b*block_leng,:)=pic_red1;
                elseif((a==area_red(c,1,2))&&(b>=area_red(c,2,1))&&(b<=area_red(c,2,2))) %down
                    pic(a*block_leng-line_leng+1:a*block_leng,(b-1)*block_leng+1:b*block_leng,:)=pic_red1;
                end
                if((b==area_red(c,2,1))&&(a>=area_red(c,1,1))&&(a<=area_red(c,1,2))) %left
                    pic((a-1)*block_leng+1:a*block_leng,(b-1)*block_leng+1:(b-1)*block_leng+line_leng,:)=pic_red2;
                elseif((b==area_red(c,2,2))&&(a>=area_red(c,1,1))&&(a<=area_red(c,1,2))) %right
                    pic((a-1)*block_leng+1:a*block_leng,b*block_leng-line_leng+1:b*block_leng,:)=pic_red2;
                end
            end
        end
    end
end
imshow(uint8(pic));
imwrite(uint8(pic),'exe_4_2_3.jpg','jpg');