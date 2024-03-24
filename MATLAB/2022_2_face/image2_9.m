%题2_8部分
clear all;
load('JpegCoeff.mat');
load('hall.mat');
img = hall_gray-128;
[len,width] = size(hall_gray);
num = ceil(len/8)*ceil(width/8);
result = zeros(64,num);
for i = 1:ceil(len/8)
    for j = 1:ceil(width/8)
        sample = img(i*8-7:8*i,8*j-7:8*j);    %分块
        dct_sample = dct2(sample);            %DCT
        q = round(dct_sample./QTAB);          %量化
        zigzag_sample = zigzag(q');            %zigzag扫描
        result(:,j+ceil(width/8)*(i-1)) = zigzag_sample';
    end
end
%处理DC系数
DC = result(1,:);
dDC = zeros(size(DC));
%差分
dDC(1) = DC(1);
for i = 2:num
    dDC(i) = DC(i-1) - DC(i);
end
%DC系数
DC_code = [];
%Huffman编码
for i = 1:num
    if(dDC(i)==0)
        cate = 0;
    else
        cate = floor(log2(abs(dDC(i))))+1;
    end
    DC_huffman = DCTAB(cate+1,2:DCTAB(cate+1:1)+1);  %DCTAB第一列对应编码长度，后面对应编码
    %Magnitude
    if(dDC(i)>=0)
        mag = dec2bin(dDC(i));     %dec2bin输出是字符向量
    else
        mag = dec2bin(-dDC(i));
        for j = 1:length(mag)
            if(mag(j)=='0')
                mag(j)='1';
            elseif(mag(j)=='1')
                mag(j)='0';
            end
        end
    end
    DC_code = [DC_code,num2str(DC_huffman),mag];    %排列后观察到由于多空格
    %原因是num2str函数会自动将行向量元素之间添加两个空格以示区分
end
%消除空格
DC_code = strrep(DC_code,'  ','');    %字符串替换
    
%AC系数
AC = result(2:64,:);   
AC_code = [];
for k = 1:num
    run = 0;
    p = AC(:,k);   %第k列
    ZRL= 0;
    m = 63;
    while(p(m)=='0')
        m=m-1;
    end
    m0 = m;
    for m = 1:m0
        flag = 0;
        if(p(m)==0)
            run = run + 1;
            if(run==16)
                AC_c0 = '11111111001';
                run = 0;
                flag = 1;
            end
        else
            size = fix(log2(abs(p(m)))+1);  %%%%%%%%%here!here!!here!!!
            for i=run*10+1:(run+1)*10 
                if(ACTAB(i,2)==size)
                    AC_huffman = num2str(ACTAB(i,4:(ACTAB(i,3)+3)));
                    if(p(m)>=0)
                        amp = dec2bin(p(m));     %dec2bin输出是字符向量
                    else
                        amp = dec2bin(-p(m));
                        for j = 1:length(amp)
                            if(amp(j)=='0')
                                amp(j)='1';
                            elseif(amp(j)=='1')
                                amp(j)='0';
                            end
                        end
                    end
                    AC_c0 = [AC_huffman,amp];
                    run=0;    %%%%%%%%%here!here!!here!!!
                    flag = 1;
                end
            end
        end
        if(flag==1)
            AC_code = [AC_code,AC_c0];
        end
    end
    AC_code = [AC_code,'1010'];
end
AC_code = strrep(AC_code,'  ','');    %字符串替换
%输出
height = len;
save('jpegcodes.mat','height','width','DC_code','AC_code');

ratio=(8*len*width)/(length(AC_code)+length(DC_code)+length(dec2bin(len))+length(dec2bin(width)));
ratio
            
            