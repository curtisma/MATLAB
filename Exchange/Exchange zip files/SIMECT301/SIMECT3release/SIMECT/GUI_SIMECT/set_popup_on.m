function set_popup_on(numpopup,str)
  if isempty(str)
    set(numpopup,'Enable','off');
    set(numpopup,'Value',1);
    set(numpopup,'String','<none>');
  else
    set(numpopup,'Enable','on');
    set(numpopup,'Value',1);
    set(numpopup,'String',str);
  end



