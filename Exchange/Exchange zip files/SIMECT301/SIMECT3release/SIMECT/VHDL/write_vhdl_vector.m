function []=write_vhdl_vector(fid,name,value)
% Write vhdl Constant vector from value and name

    fprintf(fid, '  CONSTANT %s : REAL_VECTOR := ', name);
    fprintf(fid, '(%s', '');
    
    %Flip vectors as in VHDL-AMS the coefficients are from small to big
    rev_value=fliplr(value);
    
    for i=1:length(rev_value)
    fprintf(fid, '%.12e, ', rev_value(i));
    end
    fprintf(fid, '%.1f);\n', 0);

end