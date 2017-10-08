function [line]=vhdl_tr_decomp(cdn_model,idx,model_in_out,t1,t2)

line=[];

fct_name=strrep(strrep(t1,'Num_',''),'Den_','');

sub_fct_str=getfield(model_in_out,fct_name);

for i=1:size(sub_fct_str,2)
    
    if cdn_model
        if ~isempty(findstr(t1,'Num'))
            if  (length(sub_fct_str(1,i).Num)==1) && (length(sub_fct_str(1,i).Den)==1)
              line=[line '*(' num2str(sub_fct_str(1,i).Num/sub_fct_str(1,i).Den,'%12.12e') ') ' ];                
            else
              line=[line '''LTF(' vhdl_tr(sub_fct_str(1,i),['Out_' num2str(idx) '_Num_' fct_name '_' num2str(i)],['Out_' num2str(idx) '_Den_' fct_name '_' num2str(i)],1) ')'];
            end
        else
            if  (length(sub_fct_str(1,i).Num)==1) && (length(sub_fct_str(1,i).Den)==1)
              line=[line '*(' num2str(sub_fct_str(1,i).Den/sub_fct_str(1,i).Num,'%12.12e') ') ' ];                
            else
              line=[line '''LTF(' vhdl_tr(sub_fct_str(1,i),['Out_' num2str(idx) '_Den_' fct_name '_' num2str(i)],['Out_' num2str(idx) '_Num_' fct_name '_' num2str(i)],0) ')'];
            end
        end
    else
        if ~isempty(findstr(t1,'Num'))
            if  (length(sub_fct_str(1,i).Num)==1) && (length(sub_fct_str(1,i).Den)==1)
              line=[line '*(' num2str(sub_fct_str(1,i).Num/sub_fct_str(1,i).Den,'%12.12e') ') ' ];                
            else
              line=[line '''LTF(' vhdl_tr_smash(sub_fct_str(1,i),['Out_' num2str(idx) '_Num_' fct_name '_' num2str(i)],['Out_' num2str(idx) '_Den_' fct_name '_' num2str(i)],1) ')'];
            end
        else
            if  (length(sub_fct_str(1,i).Num)==1) && (length(sub_fct_str(1,i).Den)==1)
              line=[line '*(' num2str(sub_fct_str(1,i).Den/sub_fct_str(1,i).Num,'%12.12e') ') ' ];                
            else
              line=[line '''LTF(' vhdl_tr_smash(sub_fct_str(1,i),['Out_' num2str(idx) '_Den_' fct_name '_' num2str(i)],['Out_' num2str(idx) '_Num_' fct_name '_' num2str(i)],0) ')'];
            end
        end
    end
    
end

return