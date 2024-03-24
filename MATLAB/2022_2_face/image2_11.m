clear all;
load('jpegCoeff.mat');
load('jpegcodes.mat');
load('hall.mat');
%DC还原
DC = [];
huffman = [];
i=1;
while i<=length(DC_code)
    flag=0;
    %找到huffman编码
    huffman = [huffman,DC_code(i)];
    for j=1:12
        a=isequal(double(huffman)-48,DCTAB(j,2:(DCTAB(j,1)+1))); %str2double会把占位的零自动忽略，导致译码后许多0都消失了，因此必须用double()-48  
        %注意DC_code和huffman都是字符向量
        if(length(huffman)==DCTAB(j,1) && a==1)
            flag = 1;
            break;
        end
    end
    %huffman->cate
    if(flag==1)
        flag = 0;
        if(j==1)
            bin = DC_code(i+j);
            i = i+j;
        else
            bin = DC_code(i+1:i+j-1);
            i = i+j-1;
        end
        %bin->dec
        if(j==1)
            DC=[DC,0];
        else
        if(bin(1)=='0')
            for k=1:length(bin)
                if(bin(k)=='1')
                    bin(k)='0';
                else
                    bin(k)='1';
                end
            end
            DC_mag = -bin2dec(bin);
        else
            DC_mag = bin2dec(bin);
        end
        DC = [DC,DC_mag];
        end
        huffman = [];
    end
    i = i+1;
end
%差分还原
for i=1:length(DC)
    if(i==1)
        DC(i) = DC(i);
    else
        DC(i) = DC(i-1)-DC(i);    %注意换算关系
    end
end
%DC还原完成，输出为DC

%AC还原
i=1;
EOB='1010';
ZEROS='11111111001';
huffman=[];
row=1;
col=1;
blocks = zeros(63,ceil(height/8)*ceil(width/8));      %提前确定大小
while i<=length(AC_code)
    flag = 0;
    huffman = [huffman,AC_code(i)];
    for j=1:160
        k = isequal(double(huffman)-48,ACTAB(j,4:3+ACTAB(j,3)));
        if(length(huffman)==ACTAB(j,3) && k==1)
            flag=1;
            size=ACTAB(j,2);  
            bin=AC_code(i+1:i+size);
            break;
        end
    end
    if(strcmp(huffman,EOB))
        huffman = [];
        row = 1;        %第一行
        col = col+1;    %新一列
    end
    if(strcmp(huffman,ZEROS))
        blocks(row:row+15,col)=0;    %16个零
        huffman=[];
        row = row+16;
    end
    if(flag==1)
        blocks(row:row+ACTAB(j,1)-1,col)=0;  %非零前的零
        row = row+ACTAB(j,1);
        %bin->dec
        if(bin(1)=='0')
            for k=1:length(bin)  
                if(bin(k)=='1')
                    bin(k)='0';
                else
                    bin(k)='1';
                end
            end
            blocks(row,col) = -bin2dec(bin);
        else
            blocks(row,col) = bin2dec(bin);
        end
        row = row+1;
        huffman = [];
        i = i+size;
    end
    i=i+1;
end
blocks = [DC;blocks];
        
hall2 = zeros(height,width);
block = zeros(8,8);
basic = zeros(64,1);
for i=1:ceil(height/8)
    for j=1:ceil(width/8)
        basic = blocks(:,(i-1)*ceil(width/8)+j);
        block = inv_zigzag(basic');          %逆之字形
        block = block.*QTAB;                 %反量化
        block = idct2(block);                %DCT逆变换
        %block = block+128;  %不考虑缩小压缩比时不需要-128，否则失真过度
        hall2(8*i-7:8*i,8*j-7:8*j) = block;
    end
end
save('hall2.mat','hall2');
imshow(uint8(hall2));
MSE=(1/height/width)*sum(sum((double(hall2)-double(hall_gray)).^2)); 
PSNR = 10*log10(255^2/MSE)
    