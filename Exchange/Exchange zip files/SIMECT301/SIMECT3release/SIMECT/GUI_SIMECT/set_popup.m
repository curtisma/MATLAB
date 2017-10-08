function [corrupt_var] = set_popup(popmenu,str,corrupt_var)
   set(popmenu,'Enable','On');
   contents=get(popmenu,'String');
   selected=0;
   for i=1:size(contents,1)
        if strcmp(contents{i},str)
            selected=i;
        end
    end
    if selected~=0
        set(popmenu,'Value',selected);
    else
        corrupt_var=1;
    end
end

