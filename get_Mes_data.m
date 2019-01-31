% =========================================================================
% REHAZENTER ACTIMETRY TOOLBOX
% =========================================================================
% File name:    get_6MWT_data
% -------------------------------------------------------------------------
% Subject:      Import and store measurement data
% -------------------------------------------------------------------------
% Author: F. Moissenet, G. Areno
% Date of creation: 31/01/2019
% Version: 1
% =========================================================================

function get_Mes_data(patient,toolboxFolder,nfile)

% -------------------------------------------------------------------------
% S�lection les fichiers
% -------------------------------------------------------------------------
[file,folder] = uigetfile('*.csv', 'S�lectionnez le fichier correspondant aux mesures patient','MultiSelect','on');
outputfolder = uigetdir('','S�lectionner le r�pertoire de destination du fichier de sauvegarde');
if iscell(file)
    n = size(file,2);
else
    n = 1;
end

for i = 1:nfile
    
    % ---------------------------------------------------------------------
    % Importer les mesures patient
    % ---------------------------------------------------------------------
    if nfile == 1
        data_Mes = importdata([folder,'\',file],',');
    else
        data_Mes = importdata([folder,'\',file{i}],',');
    end

    % ---------------------------------------------------------------------
    % Extraire les metadata concernant les mesures
    % ---------------------------------------------------------------------
    temp1             = data_Mes.textdata{2,1};
    temp2             = data_Mes.textdata{4,1};
    temp3             = data_Mes.textdata{5,1};
    data_Mes.SN       = temp1(16:end);
    if nfile == 1
        data_Mes.File = file;
    else
        data_Mes.File = file{i};
    end
    data_Mes.Date     = temp2(12:end);
    data_Mes.Epoch    = temp3(31:end);

    % ---------------------------------------------------------------------
    % Extraire les donn�es des mesures sur patient
    % ---------------------------------------------------------------------
    data_Mes.AccX        = data_Mes.data(:,1); % Acceleration mesur�e /X , m.s-2
    data_Mes.AccY        = data_Mes.data(:,2); % Acceleration mesur�e /Y , m.s-2
    data_Mes.AccZ        = data_Mes.data(:,3); % Acceleration mesur�e /Z , m.s-2
    data_Mes.Step        = data_Mes.data(:,4); % Nombre de pas mesur�s   , adim
    data_Mes.Lux         = data_Mes.data(:,5); % Eclairement mesur�s     , lux
    data_Mes.IncOff      = data_Mes.data(:,6); % Aucune position mesur�e , s
    data_Mes.IncStanding = data_Mes.data(:,7); % Temps en position debout, s
    data_Mes.IncSitting  = data_Mes.data(:,8); % Temps en position assise, s
    data_Mes.IncLying    = data_Mes.data(:,9); % Temps de position along�, s

    % ---------------------------------------------------------------------
    % Calculer la quantit� de mouvement (norme de l'acc�l�ration 3D)
    % ---------------------------------------------------------------------
    data_Mes.quantiteM = sqrt(data_Mes.AccX.^2 + ...
                              data_Mes.AccY.^2 + ...
                              data_Mes.AccZ.^2); % m.s-2

    % ---------------------------------------------------------------------
    % Sauvegarder les donn�es
    % ---------------------------------------------------------------------    
    cd(outputfolder);
    save([patient.lastname,'_',...
          patient.firstname,'_',...
          patient.dateofbirth,'_',...
          'Mes_',regexprep(data_Mes.Date,'/',''),'.mat'],'data_Mes');
    cd(toolboxFolder);
end