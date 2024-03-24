%do problem_2_8 first
DC = result(1,:);
DC_diff = zeros(size(DC));
for k = 1:num
    if k == 1
        DC_diff(k) = DC(k);
    else
        DC_diff(k) = DC(k-1)-DC(k);
    end
end
%get DC_diff
DC_code =[];
 for k = 1:num
     if DC_diff(k)==0
        category = 0;
     else
    category = floor(log2(abs(DC_diff(k)))+1);
     end
     DC_huffman = DCTAB(category+1,2:DCTAB(category+1,1)+1);
     %search the table2.2
     if(DC_diff(k)<0)
         bin = dec2bin(-DC_diff(k));
         for l=1:length(bin)
             if(bin(l) =='1')
                 bin(l) = '0';
             else
                 bin(l) = '1';
             end
         end
        binary = bin;
     else
         binary = dec2bin(DC_diff(k));
     end
     DC_code = [DC_code,num2str(DC_huffman),binary];%get the code
     DC_code(isspace(DC_code))=[];%delete the space
 end
 
%finish DC_code
AC = result(2:64,:);
AC_code = [];
for k=1:num
    Run = 0;
    sample = AC(:,k);
    ZRL = 0;
    for l=1:63
        if(sample(l)==0)
            Run = Run+1;
            if(Run==16)
                ZRL = ZRL+1;
                Run = 0;
            end
        else
            if(sample(l)<0)
         bin = dec2bin(-sample(l));
         for p=1:length(bin)
             if(bin(p) =='1')
                 bin(p) = '0';
             else
                 bin(p) = '1';
             end
         end
        binary = bin;
            else
         binary = dec2bin(sample(l));
            end
            
            while ZRL>0
                AC_code = [AC_code,'11111111001'];
                ZRL = ZRL-1;
            end
            AC_code = [AC_code,num2str(ACTAB(length(binary)+Run*10,4:3+ACTAB(length(binary)+Run*10,3))),binary];
                Run = 0;
        end
    end
    AC_code = [AC_code,'1010'];
end
    AC_code(isspace(AC_code)) = [];
%finish AC_code
height = len;
save('jpegcodes.mat','height','width','DC_code','AC_code');

ratio=(8*len*width)/(length(AC_code)+length(DC_code)+length(dec2bin(height))+length(dec2bin(width)));
ratio