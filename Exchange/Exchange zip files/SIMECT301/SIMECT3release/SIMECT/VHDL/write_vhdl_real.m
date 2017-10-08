function []=write_vhdl_real(fid,name,value)
% Write vhdl Constant vector from value and name

    fprintf(fid, '  CONSTANT %s : REAL := ', name);
    fprintf(fid, '%.6e;\n', value);

end