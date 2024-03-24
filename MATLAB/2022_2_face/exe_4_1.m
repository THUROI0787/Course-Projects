clear all;
close all;
clc;
for L=3:5
    freq=zeros(2^(3*L),1);
    v=freq; %freq average
    for k=1:33
        file=strcat('Faces\',int2str(k),'.bmp');
        pic=double(imread(file,'bmp'));
        [leng,width,color]=size(pic);
        for a=1:leng
            for b=1:width
                R=pic(a,b,1);
                G=pic(a,b,2);
                B=pic(a,b,3); %8bits 0~255
                num=fix(R/(2^(8-L)))*2^(2*L)+fix(G/(2^(8-L)))*2^L+fix(B/(2^(8-L)));%division for reflection
                freq(num+1)=freq(num+1)+1; %start from 1,not 0
            end
        end
        freq=freq/leng/width;
        v=v+freq/33;
    end
    if(L==3)
        v3=v;
    elseif(L==4)
        v4=v;
    else
        v5=v;
    end
end
save('exe_4_1.mat','v3','v4','v5');