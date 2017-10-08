function []=write_verilog_vector(fid,name,value)
% Write vhdl Constant vector from value and name

rev_value=fliplr(value);
for k=1:length(rev_value)
    fprintf(fid, 'parameter real %s_%s  = %s ; \n', name,num2str(k),num2str(rev_value(k),'%.12e'));

    %Flip vectors as in VHDL-AMS the coefficients are from small to big

end

end