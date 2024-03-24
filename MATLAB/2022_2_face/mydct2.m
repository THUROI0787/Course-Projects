function [ answer ] = mydct2( A )
[length,width]=size(A);
dct_1=[0:length-1]';
dct_2=[1:2:2*length-1];
mydct=sqrt(2/length).*cos((pi/2/length).*kron(dct_1,dct_2));
mydct(1,:)=mydct(1,:)./sqrt(2);
answer=mydct*A*mydct';
end