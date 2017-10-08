function DelHandle(h)

eval(['global ', h]);

if (exist(h) == 0)

else
  eval(['h2=', h, ';']);
  if ishandle(h2)
	delete(h2);
  end
end
