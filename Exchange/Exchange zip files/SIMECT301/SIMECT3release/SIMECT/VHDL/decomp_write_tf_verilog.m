function [ TF_decomp ] = decomp_write_tf_verilog(cdn_model,fid,out_num,fct_name,Num,Den,ind_imp)

%For verilog do not decompose
if cdn_model
    sub_fct_str.Num=Num;
    sub_fct_str.Den=Den;
    
%For CADENCE decompose    
else
    %Decompose in subfunctions taking into account the ind_imp
    if ~ind_imp
        %Avoid badly scaled functions due to supzmax
        sub_fct_str=tf_decomp_real(Num, Den);
    else
        %Avoid badly scaled functions due to supzmax
        sstrsx=tf_decomp_real(Den, Num);
        for i=1:size(sstrsx,2)
            sub_fct_str(i).Num=sstrsx(i).Den;
            sub_fct_str(i).Den=sstrsx(i).Num;
        end
    end
end
    
%Write functions in the vhdl file
for i=1:size(sub_fct_str,2)
    
    write_verilog_vector(fid, ['Out_' num2str(out_num) '_Num_' fct_name '_' num2str(i)], sub_fct_str(1,i).Num);
    write_verilog_vector(fid, ['Out_' num2str(out_num) '_Den_' fct_name '_' num2str(i)], sub_fct_str(1,i).Den);
    
end

%export decomposed structure for quantities write
TF_decomp=sub_fct_str;


end