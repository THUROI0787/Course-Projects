function freq = pitchtofreq(basic,pitch)
%pitch2freq 用于将唱名序列转化为频率序列。
%   输入basic为基频，pitch为唱名序列，输出freq为频率序列
freq = [];
%下面是检测基频
if basic == 'G'
    bf = 196;
end
if basic == 'C'
    bf = 220;
end
if basic == 'F' 
    bf = 349.23;
end
if basic == 'D'
    bf = 293.66;
end
if basic == 'E' %E:329.63;bE:311.13
    bf = 311.13;
end
m = 1;
while(m <= length(pitch))
    a = str2double(pitch(m))-1;
    if m == length(pitch)%最后一个音符
        f = bf;
        m = m+1;
    else %判断是否有降调和升调
        if(pitch(m+1) ~= '_' && pitch(m+1) ~= '^')
            f = bf;
            m = m+1;
        elseif pitch(m+1) == '_'
            f = bf*2;
            m = m+2;
        elseif pitch(m+1) == '^'
            f = bf*2^(-1);
            m = m+2;
        end
    end 
    %具体音阶的计算
    if a == -1
        f = 0;
    elseif a >= 3
        f = f*2^((2*a-1)/12);
    else
        f = f*2^(2*a/12);
    end
    freq = [freq,f];
end

end