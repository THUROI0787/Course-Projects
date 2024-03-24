function y = shape_linear(t)
%shape_linear 函数用于计算乐音的图1.5包络
len = length(t);
y = zeros(len,1);
for m = 1:len
    if(t(m)>=0 & t(m)<1)
        y(m) = 1.5*t(m);
    elseif(t(m)>=1 & t(m)<2)
        y(m) = -0.5*(t(m)-4);
    elseif(t(m)>=2 & t(m)<4)
        y(m) = 1;
    elseif(t(m)>=4 & t(m)<=6)
        y(m) = -0.5*(t(m)-6);
    else
        y(m) = 1;
    end
end
end