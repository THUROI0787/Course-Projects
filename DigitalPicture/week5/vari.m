function out=vari(in)
[n,~]=size(in);
out=0;
aver=0;
for i=1:n
    aver=aver+in(i,1)./n;
end
for i=1:n
    if in(i)~=0
        out=out+((in(i,1)-aver)^2)/n;
    end
end
