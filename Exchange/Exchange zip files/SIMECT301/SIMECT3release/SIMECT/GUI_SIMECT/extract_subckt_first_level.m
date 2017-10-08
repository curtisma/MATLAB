tline = fgetl(fid); %normally the view name - skip

p=1;

%Next start to read each element
tline = fgetl(fid); 

while sum(tline~=(-1))
    
    while tline(end)=='\'
        tline=[tline(1:end-1) fgetl(fid)];
    end
    if length(findstr(tline,'('))==1 && length(findstr(tline,')'))==1
        [a,b]=strtok(tline,')');

        if size(strfind(b,' '),2)==1
          [a1,b1]=strtok(b,' ');
          b1=strrep(b1,' ','');
          sub_syst_first_vect{p} = b1;
          p=p+1;
        end
    end  
      tline = fgetl(fid);
      
end

