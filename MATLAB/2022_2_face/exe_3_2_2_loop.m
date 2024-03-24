clear all;
close all;
clc;
load ('hall.mat');
[leng,width]=size(hall_gray);
sample=double(hall_gray)-128;
number=ceil(leng/8)*ceil(width/8);
Quantization=zeros(64,number);
load ('JpegCoeff.mat');

%%
password='HYW is cute!!!';
leng_pass=length(password);
leng_bin=dec2bin(leng_pass,8); %help dec2bin
password_area=ceil(leng_pass/8); %the num of blocks
ratio=[];
PSNR=[];
Pass=[];

%%
for para=1:64
    for a=1:ceil(leng/8)
        for b=1:ceil(width/8)
            
            block_num=(a-1)*ceil(width/8)+b;
            area=sample(a*8-7:a*8,b*8-7:b*8);
            area_dct=dct2(area); %DCT
            area_DC=round(area_dct./QTAB);
            
            if(1<=block_num && block_num<=8) %the first block
                if(leng_bin(block_num)=='1')
                    area_DC(para)=2*fix(area_DC(para)/2)+1;
                end
                if(leng_bin(block_num)=='0')
                    area_DC(para)=2*fix(area_DC(para)/2);
                end
            end
            
            if(block_num>=9 && block_num<=8*leng_pass+8)
                x=fix((block_num-9)/8)+1;   %这里是-9不是-8 很重要
                y=block_num-8*x;
                word_bin=dec2bin(password(x),8);
                if(word_bin(y)=='1')
                    area_DC(para)=2*fix(area_DC(para)/2)+1;
                end
                if(word_bin(y)=='0')
                    area_DC(para)=2*fix(area_DC(para)/2);
                end
            end
            area_zigzag=zigzag(area_DC);
            Quantization(:,b+(a-1)*ceil(width/8))=area_zigzag;
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
    ratio_num=(8*leng*width)/(length(AC_code)+length(DC_code)+length(dec2bin(leng))+length(dec2bin(width)));
    ratio=[ratio,ratio_num];
    
    %%
    load ('jpegcodes_exe3_2_1.mat');
    
    %%
    leng_DC=length(DC_code);
    area=[];
    DC=[];
    a=1;
    
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
    password2=[];
    password_bin=[];
    
    %%
    for a=1:ceil(leng/8)
        for b=1:ceil(width/8)
            block_num=(a-1)*ceil(width/8)+b;
            basic=blocks(:,(a-1)*ceil(width/8)+b);
            block=inv_zigzag(basic);
            
            if(1<=block_num && block_num<=8)
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
                    password2=[password2,char(bin2dec(password_bin))];
                end
            end
            
            block=block.*QTAB;
            block=idct2(block);
            block=block+128;
            re(a*8-7:a*8,b*8-7:b*8)=block;
        end
    end
    
    %%
    %password2
    MSE=1/leng/width*sum(sum((double(re)-double(hall_gray)).^2));
    PSNR_num = 10*log10(255^2/MSE);
    Pass=[Pass,isequal(password2,'HYW is cute!!!')];
    PSNR=[PSNR,PSNR_num];
end

%%
%put out
[PSNR_max,m]=max(PSNR);
ratio_out=reshape(ratio,8,8);
Pass_out=reshape(Pass,8,8);
PSNR_out=reshape(PSNR,8,8);
Pass_out'
ratio_out'
PSNR_out'
m
PSNR_max