%---------------------------------------------------
% Ce programme est la propriete exclusive de SUPELEC
% Tout  usage  non  authorise  ou reproduction de ce
% programme est strictement defendu. 
% Copyright  (c) 2010  SUPELEC  Departement SSE
% Tous droits reserves
%---------------------------------------------------
%
% fichier : gui_set_des_var.m
% auteur  : P.BENABES & C.TUGUI 
% Copyright (c) 2010 SUPELEC
% Revision: 2.0  Date: 29/10/2010
%
%---------------------------------------------------
%
% DESCRIPTION DU MODULE :
%   
%
% MODULES UTILISES :
%
%---------------------------------------------------


function gui_set_des_var(des_var)

global S

S.fig = figure('units','pixels',...
              'position',[500 500-10*(size(des_var,2)+4) 530 20*(size(des_var,2)+4)],...
              'menubar','none',...
              'name','Set design variables',...
              'numbertitle','off',...
              'resize','on'); 
          
for i=1:size(des_var,2)
             S.vars(i) = uicontrol('style','text',...
                 'units','pix',...
                 'position',[10 20+i*20 90 17],...
                 'fontsize',10,...
                 'string',[des_var(i).name '  =']);
end

for i=1:size(des_var,2)
             S.vals(i) = uicontrol('style','edit',...
                 'BackgroundColor','white',...
                 'units','pix',...
                 'position',[110 20+i*20 110 17],...
                 'fontsize',10,...
                 'string',num2str(des_var(i).value),...
                 'callback',{@vals_call,S});
             
             if (isfield(des_var(i),'min'))
                 S.valmin(i) = uicontrol('style','edit', 'BackgroundColor','white',...
                     'units','pix','position',[230 20+i*20 110 17],...
                     'fontsize',10,'string',num2str(des_var(i).min),'callback',{@vals_call,S});
             else
                 S.valmin(i) = uicontrol('style','edit','BackgroundColor','white',...
                     'units','pix','position',[230 20+i*20 110 17],...
                     'fontsize',10,'string','0','callback',{@vals_call,S});
             end
             
             if (isfield(des_var(i),'min'))
                 S.valmax(i) = uicontrol('style','edit','BackgroundColor','white',...
                     'units','pix','position',[350 20+i*20 110 17],...
                     'fontsize',10,'string',num2str(des_var(i).max),'callback',{@vals_call,S});
             else
                 S.valmax(i) = uicontrol('style','edit','BackgroundColor','white',...
                     'units','pix','position',[350 20+i*20 110 17],...
                     'fontsize',10,'string','0','callback',{@vals_call,S});
             end

             if (isfield(des_var(i),'npt'))
                 S.npt(i) = uicontrol('style','popup','BackgroundColor','white',...
                     'units','pix','position',[470 20+i*20 50 17],...
                     'fontsize',10,'string','no par|2|3|4|5|6|7|8|9|10',...
                     'value',des_var(i).npt, 'callback',{@vals_call,S});
             else
                 S.npt(i) = uicontrol('style','popup','BackgroundColor','white',...
                     'units','pix','position',[470 20+i*20 50 17],...
                     'fontsize',10,'string','no par|2|3|4|5|6|7|8|9|10',...
                     'value',1, 'callback',{@vals_call,S});
             end
             
             
end

uicontrol('style','text',...
     'units','pix',...
     'ForegroundColor','red',...
     'position',[10 20+(i+2)*20 210 17],...
     'fontsize',12,...
     'string','Input actual value without units!');  

uicontrol('style','text',...
     'units','pix',...
     'ForegroundColor','red',...
     'position',[230 20+(i+2)*20 110 17],...
     'fontsize',12,...
     'string','Min value!');  

uicontrol('style','text',...
     'units','pix',...
     'ForegroundColor','red',...
     'position',[350 20+(i+2)*20 110 17],...
     'fontsize',12,...
     'string','Max value!');  

uicontrol('style','push',...
     'units','pixels',...
     'ForegroundColor','blue',...
     'position',[20 10 90 20],...
     'fontsize',10,...
     'string','Save...',...
     'callback',{@save_call,S});
             
uicontrol('style','push',...
     'units','pixels',...
     'ForegroundColor','blue',...
     'position',[120 10 90 20],...
     'fontsize',10,...
     'string','Cancel...',...
     'callback',{@cancel_call,S});
 
uicontrol('style','push',...
     'units','pixels',...
     'ForegroundColor','blue',...
     'position',[240 10 90 20],...
     'fontsize',10,...
     'string','Write File...',...
     'callback',{@write_file,S});

 uicontrol('style','push',...
     'units','pixels',...
     'ForegroundColor','blue',...
     'position',[360 10 90 20],...
     'fontsize',10,...
     'string','Load File...',...
     'callback',{@load_file,S});
 
uiwait;
return;
            
            
function [] = save_call(varargin)
% Callback for pushbutton, deletes one line from listbox.

global S

ok=1;

for i=1:size(S.des_var,2)
    if ~isempty(str2double(get(S.vals(i),'String')))
        S.des_var(i).value=str2double(get(S.vals(i),'String'));
    else
        S.des_var(i).value=NaN;
        errordlg(['Variable value not set for ' S.des_var(i).name '!'],'Design variables');
        ok=0;
    end
    
    S.des_var(i).npt=get(S.npt(i),'value');
    if (S.des_var(i).npt>1)
        if ~isempty(str2double(get(S.valmin(i),'String')))
            S.des_var(i).min=str2double(get(S.valmin(i),'String'));
        else
            S.des_var(i).min=0;
            errordlg(['min value not set for ' S.des_var(i).name '!'],'Design variables');
            ok=0;
        end

        if ~isempty(str2double(get(S.valmax(i),'String')))
            S.des_var(i).max=str2double(get(S.valmax(i),'String'));
        else
            S.des_var(i).max=0;
            errordlg(['max value not set for ' S.des_var(i).name '!'],'Design variables');
            ok=0;
        end
    else
        if ~isempty(str2double(get(S.valmin(i),'String')))
            S.des_var(i).min=str2double(get(S.valmin(i),'String'));
        end
        if ~isempty(str2double(get(S.valmax(i),'String')))
            S.des_var(i).max=str2double(get(S.valmax(i),'String'));
        end
    end
    
end

if ok
    uiresume;
    close(S.fig);
end

function [] = cancel_call(varargin)
% Callback for pushbutton, deletes one line from listbox.

global S

uiresume;
close(S.fig);

function [] = vals_call(varargin)
% Callback for variables textbox.

function [] = write_file(varargin)
% Callback for pushbutton, deletes one line from listbox.

global S

in_var=get(S.edit3,'String');
if strcmp(in_var,'...')||~isstr(in_var)
    errordlg('Please set variant before saving!','SIMECT Save problem');
else
    if ~isdir([S.model_par.simrep '/variables/'])
      mkdir([S.model_par.simrep '/variables/']) ;
    end
    
    out_var=get(S.edit3,'String');
    if (S.sim_subckt==1)
      save_str=[S.model_par.simrep '/variables/' 'param_' S.model_par.cell '_' S.model_par.subcell out_var '.m'];
    else
      save_str=[S.model_par.simrep '/variables/' 'param_' S.model_par.cell out_var '.m'];
    end
    [file,path] = uiputfile(save_str,'Save param variant');
    if (file(1)~=0)&&(path(1)~=0)

        variant_file=[path '/' file];
        fid_sch = fopen(variant_file, 'w');

        fprintf(fid_sch,'ind=0 ;\n');    
        fprintf(fid_sch,'param=[];\n');    

        for i=1:size(S.des_var,2)

            ok=1 ;
            S.des_var(i).npt=get(S.npt(i),'value');
            if (S.des_var(i).npt>1)
                if ~isempty(str2double(get(S.valmin(i),'String')))
                    S.des_var(i).min=str2double(get(S.valmin(i),'String'));
                else
                    S.des_var(i).min=0;
                    errordlg(['min value not set for ' S.des_var(i).name '!'],'Design variables');
                    ok=0;
                end

                if ~isempty(str2double(get(S.valmax(i),'String')))
                    S.des_var(i).max=str2double(get(S.valmax(i),'String'));
                else
                    S.des_var(i).max=0;
                    errordlg(['max value not set for ' S.des_var(i).name '!'],'Design variables');
                    ok=0;
                end
                if (ok)
                  fprintf(fid_sch,'\n');    
                  fprintf(fid_sch,'ind=ind+1 ;\n');    
                  fprintf(fid_sch,['param(ind).nam=''' S.des_var(i).name ''';\n']);    
                  fprintf(fid_sch,['param(ind).min=' num2str(S.des_var(i).min) ';\n']);    
                  fprintf(fid_sch,['param(ind).max=' num2str(S.des_var(i).max) ';\n']);    
                  fprintf(fid_sch,['param(ind).npt=' num2str(S.des_var(i).npt) ';\n']);    

                end
            end
        end
        fclose(fid_sch);
     
    end
end


function [] = load_file(varargin)
% Callback for pushbutton, deletes one line from listbox.

global S

in_var=get(S.edit3,'String');
if strcmp(in_var,'...')||~isstr(in_var)
    errordlg('Please set variant before saving!','SIMECT Save problem');
else
    if ~isdir([S.model_par.simrep '/variables/'])
      mkdir([S.model_par.simrep '/variables/']) ;
    end
    
    out_var=get(S.edit3,'String');
    if (S.sim_subckt==1)
      save_str=[S.model_par.simrep '/variables/' 'param_' S.model_par.cell '_' S.model_par.subcell out_var '.m'];
    else
      save_str=[S.model_par.simrep '/variables/' 'param_' S.model_par.cell out_var '.m'];
    end
    [file,path] = uigetfile(save_str,'load param variant');
    if (file(1)~=0)&&(path(1)~=0)

        for k=1:size(S.des_var,2)
            set(S.valmin(k),'String','0');
            set(S.valmax(k),'String','0');
            set(S.npt(k),'value',1);
        end
        
        variant_file=[path file];
        param=[] ;
        eval(['clear ' file(1:end-2)]); % clear the last values
        run(variant_file);
        for k=1:ind
            for l=1:size(S.des_var,2)
                if strcmp(S.des_var(l).name,param(k).nam)
                    set(S.valmin(l),'String',num2str(param(k).min));
                    set(S.valmax(l),'String',num2str(param(k).max));
                    set(S.npt(l),'value',param(k).npt);    
                end
            end
        end
    end
end






