function []=write_verilog_real(fid,name,value)
% Write vhdl Constant vector from value and name

    fprintf(fid, 'parameter real %s = ', name);
    fprintf(fid, '%.6e;\n', value);

end