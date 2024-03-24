function z=f_rotate(z,theta)
for i=1:length(z)
    if(imag(z(i)>0))
        z(i)=z(i)*exp(-1i*theta*pi/180);
    elseif(imag(z(i)<0))
        z(i)=z(i)*exp(1i*theta*pi/180);
    end
end