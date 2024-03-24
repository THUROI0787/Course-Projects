function out=border(pic_in,x,y)
[h,w]=size(pic_in);
pic_bord=zeros(h+2,w+2,'uint8');
for i=1:h
    for j=1:w
        pic_bord(i+1,j+1)=pic_in(i,j);
    end
end
for i=2:h+1
    pic_bord(i,1)=pic_bord(i,2);
    pic_bord(i,w+2)=pic_bord(i,w+1);
end
for j=2:w+1
    pic_bord(1,j)=pic_bord(2,j);
    pic_bord(h+2,j)=pic_bord(h+1,j);
end
pic_bord(1,1)=pic_bord(2,2);pic_bord(1,w+2)=pic_bord(2,w+1);
pic_bord(h+2,1)=pic_bord(h+1,2);pic_bord(h+2,w+2)=pic_bord(h+1,w+1);
A=zeros(3,3);
x=x+1;y=y+1;
A(1,1)=pic_bord(x-1,y-1);A(1,2)=pic_bord(x-1,y);A(1,3)=pic_bord(x-1,y+1);
A(2,1)=pic_bord(x,y-1);A(2,2)=pic_bord(x,y);A(2,3)=pic_bord(x,y+1);
A(3,1)=pic_bord(x+1,y-1);A(3,2)=pic_bord(x+1,y);A(3,3)=pic_bord(x+1,y+1);
amax=max(max(A));amin=min(min(A));
if (amax-A(2,2))^2>=(amin-A(2,2))^2
    out=(amax-A(2,2))^2;
else
    out=(amin-A(2,2))^2;
end