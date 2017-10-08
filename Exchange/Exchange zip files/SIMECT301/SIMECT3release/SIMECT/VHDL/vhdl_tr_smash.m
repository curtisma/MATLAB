function [res]=vhdl_tr_smash(sub_fct_str_idx,t1,t2,ind_imp)

res=[];

if ind_imp
    r1=getfield(sub_fct_str_idx,'Num');
    r2=getfield(sub_fct_str_idx,'Den');
else
    r1=getfield(sub_fct_str_idx,'Den');
    r2=getfield(sub_fct_str_idx,'Num');
end

if ~(size(r1,1)==1&&size(r2,1)==1)
    warndlg('SMASH VHDL-AMS ecuations extraction warning','SMASH VHDL-AMS');
end

res=[t1 ',' t2];

return