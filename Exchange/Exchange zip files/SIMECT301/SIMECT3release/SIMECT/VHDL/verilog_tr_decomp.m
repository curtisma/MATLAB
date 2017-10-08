function [line]=verilog_tr_decomp(namout,idx,model_in_out,t1,t2)

line=[' +'];

fct_name=strrep(strrep(t1,'Num_',''),'Den_','');

sub_fct_str=getfield(model_in_out,fct_name);

   
    if ~isempty(findstr(t1,'Num'))
        if  (length(sub_fct_str(1).Num)==1) && (length(sub_fct_str.Den)==1)
            if (sub_fct_str(1).Num==0)
                line=[line '0.0' ];       
            else
                line=[line namout '*(' num2str(sub_fct_str(1).Num/sub_fct_str.Den,'%12.12e') ') ' ];       
            end
        else
          line=[line 'laplace_nd(' namout ',' verilog_tr(sub_fct_str,['Out_' num2str(idx) '_Num_' fct_name '_1' ],['Out_' num2str(idx) '_Den_' fct_name '_1' ],1) ')'];
        end
    else
        if  (length(sub_fct_str(1).Num)==1) && (length(sub_fct_str(1).Den)==1)
            if (sub_fct_str(1).Den==0)
                line=[line '0.0' ];       
            else
                line=[line namout '*(' num2str(sub_fct_str(1).Den/sub_fct_str(1).Num,'%12.12e') ') ' ];   
            end
        else
          line=[line 'laplace_nd(' namout ',' verilog_tr(sub_fct_str(1),['Out_' num2str(idx) '_Den_' fct_name '_1' ],['Out_' num2str(idx) '_Num_' fct_name '_1'],0) ')'];
        end
    end


end

