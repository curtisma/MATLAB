if(~isdeployed && ~ismcc)
%% Matlab Initialization - Runs at startup
mypath = userpath;
compName = getComputerName();
% mypath = mypath(1:end-1);

exchangeDIR = fullfile(mypath, 'Exchange');
addpath(exchangeDIR);  % Scripts and functions downloaded from the MATLAB exchange
addpath(fullfile(mypath, 'Undocumented')); 
% addpath(fullfile(mypath, 'projects'));
addpath(fullfile(mypath, 'functions')); % A variety of home made functions

%% setup Github Repository and other places
if(strcmp(compName,'curtis-laptop'))
    GITHUB_LOC = 'E:\Documents\GitHub';
elseif(strcmp(compName,'curtis-desktop'))
    GITHUB_LOC = 'D:\Documents\GitHub';
elseif(strcmp(compName,'cedmayberclt01'))
    GITHUB_LOC = 'R:\prj\crdc_dev\mayberc\Github';
    SPECTRE_LIBS_LOC = 'R:/rds/prod/tools/cadence/default_mmsim/linux/tools.lnx86/spectre/matlab/64bit';
    LINUX_MATLAB_LOC = 'R:\home\mayberc\Documents\MATLAB';
elseif(isunix)
    GITHUB_LOC = '/prj/crdc_dev/mayberc/Github';
    SPECTRE_LIBS_LOC = '/rds/prod/tools/cadence/default_mmsim/linux/tools.lnx86/spectre/matlab/64bit';
else
    warning('no github location set');
    GITHUB_LOC = [];
end

%% Specific Projects
% addpath(fullfile(mypath, '\projects\MRIG'));
% addpath(fullfile(mypath, '\projects\MRIG\11-6-13'));
% addpath(fullfile(mypath, '\projects\MRIG\Rate Table Testing [unmatched] 12-5-13'));
% addpath(fullfile(mypath, '\projects\MRIG\GTBE'));
% addpath(fullfile(mypath, '\projects\MRIG\GTBE\PLL'));
% addpath(fullfile(mypath, '\projects\MRIG\GTBE\serial'));
% addpath(fullfile(mypath, '\Projects\MRIG\GTBE\synth'));
% addpath(fullfile(mypath, '\Projects\skyCds\skyVer'));

%% Toolboxes
% addpath(fullfile(mypath,'cds'))
% addpath(fullfile(mypath,'skyCds'))
addpath(fullfile(mypath,'skyCds/imgs'))
if(~isempty(GITHUB_LOC))
    % IMEMS
%     addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar')); % Gyroscope Characterization Toolbox
%     addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar\source')); 
%     addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar\source\instruments')); 
    addpath(fullfile(GITHUB_LOC, 'MATLAB_tfigure'));
%     addpath(fullfile(GITHUB_LOC, 'VirtuosoToolbox'));
    addpath(fullfile(GITHUB_LOC, 'exportToPPTX'));
    addpath(fullfile(GITHUB_LOC, 'xlsxSheets'));
    if(~strcmp(getComputerName(),'cedmayberclt01'))
        addpath(fullfile(GITHUB_LOC, 'GTBE\firmware\GTBEA_serial\MATLAB_GTBEA')); % GTBEA Serial Interface
%         addpath(fullfile(SPECTRE_LIBS_LOC, 'matlab')); % Spectre/RF matlab toolbox
%         addpath(fullfile(SPECTRE_LIBS_LOC, 'simulink')); % Spectre/RF Simulink toolbox
    addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar')); % Gyroscope Characterization Toolbox
    addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar\source')); 
    addpath(fullfile(GITHUB_LOC, 'MATLAB_gyroChar\source\instruments')); 
    end
    % Curtis
%     addpath(fullfile(GITHUB_LOC, 'MATLAB_smith_circles_2')); % Smith Chart Circles 2 Toolbox
%     addpath(fullfile(GITHUB_LOC, 'MATLAB_cadenceVirtuoso')); % Cadence Virtuoso Toolbox
    % Skyworks
%     addpath(fullfile(GITHUB_LOC, 'skyVer')); % Skyworks verification toolbox
%     addpath(fullfile(GITHUB_LOC, 'skyVer\SIF2STC')); % Skyworks verification toolbox
end

%% Functions
addpath(fullfile(mypath, '\functions\dynaest')); % Dynamic estimator utility
addpath(fullfile(mypath, '\functions\saveppt2\saveppt2')); % PPT saving function
addpath(fullfile(mypath, '\functions\pptfigure')); % PPT saving function
addpath(fullfile(mypath, '\functions\figtitle_v3')); % adds title to subplot figure

%% Exchange downloads
addpath(fullfile(exchangeDIR,'sync_backup'));
addpath(fullfile(exchangeDIR,'createTable'));
addpath(fullfile(exchangeDIR,'uiextras'));
% GUI Layout toolbox
% addpath(fullfile(exchangeDIR,'GUILayout-v1p17','GUILayout-v1p17'));
% addpath(fullfile(exchangeDIR,'GUILayout-v1p17','GUILayout-v1p17','layout'));
% addpath(fullfile(exchangeDIR,'GUILayout-v1p17','GUILayout-v1p17','layoutHelp'));
% addpath(fullfile(exchangeDIR,'GUILayout-v1p17','GUILayout-v1p17','Patch'));
%% Sync select folders with Linux MATLAB DIR
if(strcmp(getComputerName(),'cedmayberclt01'))
    if(exist(fullfile(LINUX_MATLAB_LOC,'cds'),'dir'))
%         disp('Syncing with Linux MATLAB Folder')
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'cds'), fullfile(GITHUB_LOC, 'VirtuosoToolbox'));
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'skyCds'), fullfile(mypath,'skyCds'));
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'VirtuosoToolbox'), fullfile(GITHUB_LOC, 'VirtuosoToolbox'));
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'skyVer'), fullfile(GITHUB_LOC, 'skyVer'));
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'MATLAB_tfigure'), fullfile(GITHUB_LOC, 'MATLAB_tfigure'));
%         syncfolder(fullfile(LINUX_MATLAB_LOC,'exportToPPTX'), fullfile(GITHUB_LOC, 'exportToPPTX'));
        addpath(SPECTRE_LIBS_LOC); % Skyworks verification toolbox
    else
        warning([ 'Not connected to ' LINUX_MATLAB_LOC]);
    end
end
%% Temporary
% addpath(fullfile(mypath, 'cdsTemp')); 
% addpath(fullfile(mypath, 'cdsTemp\cds')); 
% addpath(fullfile(mypath, 'cdsTemp\skyCds')); 
end