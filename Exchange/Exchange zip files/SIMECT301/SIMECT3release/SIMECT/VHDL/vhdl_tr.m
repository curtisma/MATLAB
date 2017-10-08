function [res]=vhdl_tr(sub_fct_str_idx,t1,t2,ind_imp)

res=[];

if ind_imp
    r1=getfield(sub_fct_str_idx,'Num');
    r2=getfield(sub_fct_str_idx,'Den');
else
    r1=getfield(sub_fct_str_idx,'Den');
    r2=getfield(sub_fct_str_idx,'Num');
end

res='(';

%When a single element in vector
if size(r1,2)<=1 
    for i=0:size(r1,2)-1
        res=[res t1 '(' num2str(i) '),'];
    end
    
    res=[res t1 '(' num2str(size(r1,2)) ')), ('];
%Normally    
else
    for i=0:size(r1,2)-2
        res=[res t1 '(' num2str(i) '),'];
    end
    
    res=[res t1 '(' num2str(size(r1,2)-1) ')), ('];
end


%When a single element in vector
if size(r2,2)<=1 
    for i=0:size(r2,2)-1
        res=[res t2 '(' num2str(i) '),'];
    end
    
    res=[res t2 '(' num2str(size(r2,2)) '))'];
%Normally    
else
    for i=0:size(r2,2)-2
        res=[res t2 '(' num2str(i) '),'];
    end
    
    res=[res t2 '(' num2str(size(r2,2)-1) '))'];
end

return