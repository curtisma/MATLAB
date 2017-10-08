function set_popup_off(numpopup,str)
    set(numpopup,'Enable','off');
    if ~isempty(str)
        set(numpopup,'String',str);
    end
    set(numpopup,'Value',1);