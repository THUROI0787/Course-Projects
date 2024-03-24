%
clear all;
load('jpegCoeff.mat');
load('jpegcodes.mat');
% load('hall.mat');
load('snow.mat');
QTAB = QTAB;

%%
%DC
len_DC=length(DC_code);  %DC_code:stream
huff=[];
DC=[];
i=1;
while i<=len_DC
    flag=0;
    huff=[huff,DC_code(i)];
    for j=1:12
        k=isequal(double(huff)-48,DCTAB(j,2:(DCTAB(j,1)+1)));% 
        if((length(huff)==DCTAB(j,1)) && k)
            flag=1;
            break;
        end
    end
    %DC category
    if(flag)
        flag=0;
        if(j==1)
            bin=DC_code(i+j);
            i=i+1;
        else
            bin=DC_code(i+1:i+j-1);
            i=i+j-1;
        end
        if(j==1)
            DC=[DC,0];
        else
            if(bin(1)=='0')
                for l=1:length(bin)
                    if(bin(l)=='1')
                        bin(l)='0';
                    else
                        bin(l)='1';
                    end
                end
                DC_number=-bin2dec(bin);
            else
                DC_number=bin2dec(bin);
            end
            %get number
            DC=[DC,DC_number];
        end
        huff=[];
    end
    i=i+1;
end
for p = 1:length(DC)
    if(p==1)
        DC(p) = DC(p);
    else
        DC(p) = DC(p-1)-DC(p);
    end
end
%finish DC_inv

%%
%AC
sizen_AC=length(AC_code);
blocks=zeros(63,ceil(height/8)*ceil(width/8));
i=1;
row=1;
huffman=[];
EOB='1010';
ZEROS='11111111001';
col=1;
while i<=sizen_AC
    flag=0;
    huffman = [huffman,AC_code(i)];
    for j=1:160
        k = isequal(double(huffman)-48,ACTAB(j,4:3+ACTAB(j,3)));
        if(length(huffman)==ACTAB(j,3) && k)
            flag=1;
            size=ACTAB(j,2);
            bin=AC_code(i+1:i+size);
            break;
        end
    end
    %EOB
    if(strcmp(huffman,EOB))
        huffman=[];
        row=1;
        col=col+1;
    end
    %ZRL
    if(strcmp(huffman,ZEROS))
        blocks(row:row+15,col)=0;
        huffman=[];
        row=row+16;
    end
    
    if(flag)
        blocks(row:row+ACTAB(j,1)-1,col)=0;
        row=row+ACTAB(j,1);
        if(bin(1)=='0')
            for l=1:size
                if(bin(l)=='1')
                    bin(l)='0';
                else
                    bin(l)='1';
                end
            end
            blocks(row,col)=-bin2dec(bin); %
        else
            blocks(row,col)=bin2dec(bin);
        end
        row=row+1;
        huffman=[];
        i=i+size;
    end
    i=i+1;
end
%finish AC_inv
blocks = [DC;blocks];

%%
reproduct = zeros(height,width);
block = zeros(8,8);
basic = zeros(64,1);
for i = 1:ceil(height/8)
    for j = 1:ceil(width/8)
        reproduct(i*8-7:i*8,j*8-7:j*8)=idct2(inv_zigzag(blocks(:,(i-1)*ceil(width/8)+j)).*QTAB);%+128;
    end
end
save('reproduct.mat','reproduct');
imshow(uint8(reproduct));
%imwrite(uint8(reproduct),'exe_2_11.png','png');
imwrite(uint8(reproduct),'exe_2_13.png','png');
MSE=1/height/width*sum(sum((double(reproduct)-double(snow)).^2));
PSNR = 10*log10(255^2/MSE);

PSNR %read