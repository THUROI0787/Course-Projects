Q=abs(Quantization);
QQ=max(Q');
Q_zero=[];
for a=1:64
    if(QQ(a)==0)
        Q_zero=[Q_zero,a];
    end
end
Q_zero;
%Q_zero=[37,45,46,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64];
length(Q_zero)