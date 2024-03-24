function [c,B] = inv_remola(A)
AA = A(end:-1:1);
if(AA(1)~=0)
    b=1;
else
    b=find(AA~=0,1,'first');
end

if(AA(b)==1)
    c='1';
else
    c='0';
end
AA(b)=0;  

B=AA(end:-1:1); %change A:delete the 1/-1
end