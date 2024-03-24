function [B] = remola(A,a)
AA = A(end:-1:1);
if(AA(1)~=0)
    b=1;
else
    b=find(AA~=0,1,'first')-1;
end

if(a=='1')
    AA(b)=1;
else
    AA(b)=-1;
end

BB=AA(end:-1:1);
B=BB';
end