function [ out ] = txtcmp( txtFile1, txtFile2 )
%txtcmp Compares two text files.  
%	Returns true if they are identical.  Returns false if they have any 
%	differences and does a visdiff of the files highlighting the 
%   differences if they have differences.
% See also: loadTextFile, visdiff
    file1 = string(loadTextFile(txtFile1));
    file2 = string(loadTextFile(txtFile2));
    out = file1 == file2;
    if(~out)
        visdiff(txtFile1, txtFile2,'text');
    end    
end

