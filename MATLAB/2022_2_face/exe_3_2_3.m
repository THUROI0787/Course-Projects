clear all;
close all;
clc;
load ('hall.mat');
[leng,width]=size(hall_gray);
sample=double(hall_gray)-128;
number=ceil(leng/8)*ceil(width/8); %15*21=315
Quantization=zeros(64,number);
load ('JpegCoeff.mat');

%%
password='HYW is cute!!!';
leng_pass=length(password);
leng_bin=dec2bin(leng_pass,8); %help dec2bin
password_area=ceil(leng_pass/8); %the num of blocks

%%
for a=1:ceil(leng/8)
    for b=1:ceil(width/8)
        
        block_num=(a-1)*ceil(width/8)+b;
        area=sample(a*8-7:a*8,b*8-7:b*8);
        area_dct=dct2(area); %DCT
        area_DC=round(area_dct./QTAB);
        
        area_zigzag=zigzag(area_DC);  %%不是area_DC的转置！
        if(1<=block_num && block_num<=8) %the first block
            Quantization(:,block_num)=remola(area_zigzag,leng_bin(block_num));
        elseif(block_num>=9 && block_num<=8*leng_pass+8)
            x=fix((block_num-9)/8)+1;   %这里是-9不是-8 很重要
            y=block_num-8*x;
            word_bin=dec2bin(password(x),8);
            Quantization(:,block_num)=remola(area_zigzag,word_bin(y));
        else
            Quantization(:,block_num)=area_zigzag;
        end
    end
end

%%
DC_data=Quantization(1,:);
differ_data=zeros(number,1);
for a=1:number
    if(a==1)
        differ_data(a)=DC_data(a);
    else
        differ_data(a)=DC_data(a-1)-DC_data(a);
    end
end
DC_code=[];
for a=1:number
    if(differ_data(a)==0)
        category=0;
    else
        category=fix(log2(abs(differ_data(a)))+1);
    end
    pre_err=DCTAB(category+1,2:DCTAB(category+1,1)+1);
    origin_bin=dec2bin(abs(differ_data(a)));
    if(differ_data(a)<0)
        bin=[];
        for q=1:length(origin_bin)
            if(origin_bin(q)=='1')
                bin=[bin,'0'];
            else
                bin=[bin,'1'];
            end
        end
    else
        bin=origin_bin;
    end
    DC_code=[DC_code,num2str(pre_err),bin];
    DC_code(find(isspace(DC_code)))=[];
end

%%
AC_code=[];
AC_data=Quantization(2:64,:);
for a=1:number
    run=0;
    data=AC_data(:,a);
    ZRL_number=0;
    for b=1:63
        if(data(b)==0)
            run=run+1;
            if(run==16)
                ZRL_number=ZRL_number+1;
                run=0;
            end
        else
            num_origin=dec2bin(abs(data(b)));
            if(data(b)<0)
                num=[];
                for q=1:length(num_origin)
                    if(num_origin(q)=='1')
                        num=[num,'0'];
                    else
                        num=[num,'1'];
                    end
                end
            else
                num=num_origin;
            end
            size_num=length(num);
            while ZRL_number>0
                AC_code=[AC_code,'11111111001'];
                ZRL_number=ZRL_number-1;
            end
            endplace=ACTAB(size_num+run*10,3);
            AC_code=[AC_code,num2str(ACTAB(size_num+run*10,4:3+endplace)),num];
            run=0;
        end
    end
    AC_code=[AC_code,'1010'];
end
AC_code(find(isspace(AC_code)))=[];
%%
save('jpegcodes_exe3_2_1.mat','leng','width','DC_code','AC_code');
ratio=(8*leng*width)/(length(AC_code)+length(DC_code)+length(dec2bin(leng))+length(dec2bin(width)));
ratio