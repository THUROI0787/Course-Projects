clear all;
close all;
clc;
load ('jpegcodes_exe3_2_1.mat');
load ('JpegCoeff.mat');

%%
leng_DC=length(DC_code);
area=[];
DC=[];
a=1;
para=17;

%%
while a<=leng_DC
    flag=0;
    area=[area,DC_code(a)];
    
    for b=1:12
        
        k=isequal(double(area-48),DCTAB(b,2:(DCTAB(b,1)+1)));
        if((length(area)==DCTAB(b,1)) && isequal(double(area-48),DCTAB(b,2:(DCTAB(b,1)+1))))
            flag=1;
            break;
        end
    end
    
    if(flag==1)
        flag=0;
        if(b==1)
            count=DC_code(a+b);
            a=a+1;
        else
            count=DC_code(a+1:a+b-1);
            a=a+b-1;
        end
        
        if(b==1)
            DC=[DC,0];
        else
            flag0=1;
            if(count(1)=='0')
                flag0=0;
                for c=1:length(count)
                    if(count(c)=='1')
                        count(c)='0';
                    else
                        count(c)='1';
                    end
                end
            end
            if(flag0==0)
                DC_num=bin2dec(count)*(-1);
            else
                DC_num=bin2dec(count);
            end
            DC=[DC,DC_num];
        end
        area=[];
    end
    a=a+1;
end

%%
leng_AC=length(AC_code);
blocks=zeros(63,ceil(leng/8)*ceil(width/8));
a=1;
blockplace=1;
area=[];
EOB='1010';
ZEROS='11111111001';
line=1;
while a<=leng_AC
    flag=0;
    area=[area,AC_code(a)];
    for b=1:160
        if(length(area)==ACTAB(b,3) && isequal(double(area-48),ACTAB(b,4:3+ACTAB(b,3))))
            flag=1;
            le=ACTAB(b,2);
            temp_num=AC_code(a+1:a+le);
            break;
        end
    end
    if(strcmp(area,EOB))%?
        area=[];
        blockplace=1;
        line=line+1;
    end
    if(strcmp(area,ZEROS))
        blocks(blockplace:blockplace+15,line)=0;
        area=[];
        blockplace=blockplace+16;
    end
    if(flag==1)
        blocks(blockplace:blockplace+ACTAB(b,1)-1,line)=0;
        blockplace=blockplace+ACTAB(b,1);
        flag0=1;
        if(temp_num(1)=='0')
            flag0=0;
            for c=1:le
                if(temp_num(c)=='1')
                    temp_num(c)='0';
                else
                    temp_num(c)='1';
                end
            end
        end
        if(flag0==0)
            blocks(blockplace,line)=bin2dec(temp_num)*(-1);
        else
            blocks(blockplace,line)=bin2dec(temp_num);
        end
        blockplace=blockplace+1;
        area=[];
        a=a+le;
    end
    a=a+1;
end
DC_fin=zeros(length(DC),1);
for a=1:length(DC)
    if(a>1)
        DC(a)=DC(a-1)-DC(a);
    end
end
blocks=[DC;blocks];
re=zeros(leng,width);
basic=zeros(64,1);
password_leng_bin=[];
password=[];
password_bin=[];

%%
for a=1:ceil(leng/8)
    for b=1:ceil(width/8)
        block_num=(a-1)*ceil(width/8)+b;
        basic=blocks(:,(a-1)*ceil(width/8)+b);
        block=inv_zigzag(basic);
        
        if(1<=block_num && block_num<=7)
            password_leng_bin=[password_leng_bin,char(mod(block(para),2)+48)];
        end
        if(block_num==8)
            password_leng_bin=[password_leng_bin,char(mod(block(para),2)+48)];
            password_leng=bin2dec(password_leng_bin);
        end
        if(block_num>=9 && block_num<=8*password_leng+8)
            x=fix((block_num-9)/8)+1;   %这里是-9不是-8 很重要
            y=block_num-8*x;
            if(y==1)
                password_bin=[];
            end
            password_bin=[password_bin,char(mod(block(para),2)+48)];
            if(y==8)
                password=[password,char(bin2dec(password_bin))];
            end
        end
        
        re(a*8-7:a*8,b*8-7:b*8)=idct2(block.*QTAB)+128;
    end
end

%%
imshow(uint8(re));
imwrite(uint8(re),'exe_3_2_2.png','png');
password
load('hall.mat');
MSE=1/leng/width*sum(sum((double(re)-double(hall_gray)).^2));
PSNR = 10*log10(255^2/MSE);
PSNR