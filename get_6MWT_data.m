% =========================================================================
% REHAZENTER ACTIMETRY TOOLBOX
% =========================================================================
% File name:    get_6MWT_data
% -------------------------------------------------------------------------
% Subject:      Import and store 6MWT data
% -------------------------------------------------------------------------
% Author: F. Moissenet, G. Areno
% Date of creation: 31/01/2019
% Version: 1
% =========================================================================

function get_6MWT_data(patient,toolboxFolder)

% -------------------------------------------------------------------------
% Importer le 6MWT
% -------------------------------------------------------------------------
[file,folder] = uigetfile('*_6MWT*.csv', 'Sélectionnez le fichier correspondant au test de 6 minutes');
data_6MWT     = importdata([folder,file],',');

% -------------------------------------------------------------------------
% Extraire les metadata concernant le 6MWT
% -------------------------------------------------------------------------
temp1              = data_6MWT.textdata{2,1};
temp2              = data_6MWT.textdata{3,1};
temp3              = data_6MWT.textdata{4,1};
temp4              = data_6MWT.textdata{5,1};
data_6MWT.SN       = temp1(16:end);
data_6MWT.File     = file;
data_6MWT.Date     = temp3(12:end);
data_6MWT.Hour     = temp2(12:13);
data_6MWT.Min      = temp2(15:16);
data_6MWT.Sec      = temp2(18:19);
data_6MWT.Epoch    = temp4(31:end);
data_6MWT.ref_6MWT = [];
clear temp1 temp2 temp3 temp4;

% -------------------------------------------------------------------------
% Extraire les données du 6 minutes (accélérations uniquement)
% -------------------------------------------------------------------------
data_6MWT.AccX        = data_6MWT.data(:,1);   % Acceleration mesurée /X    , m.s-2
data_6MWT.AccY        = data_6MWT.data(:,2);   % Acceleration mesurée /Y    , m.s-2
data_6MWT.AccZ        = data_6MWT.data(:,3);   % Acceleration mesurée /Z    , m.s-2
data_6MWT.AccNORM     = sqrt(data_6MWT.AccX.^2 + ...
                           data_6MWT.AccY.^2 + ...
                           data_6MWT.AccZ.^2); % Norme de l'acceleration 3D , m.s-2
data_6MWT.Step        = data_6MWT.data(:,4);   % Nombre de pas mesurés      , adim
data_6MWT.Lux         = data_6MWT.data(:,5);   % Eclairement mesurés        , lux
data_6MWT.IncOff      = data_6MWT.data(:,6);   % Aucune position mesurée    , s
data_6MWT.IncStanding = data_6MWT.data(:,7);   % Temps en position debout   , s
data_6MWT.IncSitting  = data_6MWT.data(:,8);   % Temps en position assise   , s
data_6MWT.IncLying    = data_6MWT.data(:,9);   % Temps de position alongé   , s

% -------------------------------------------------------------------------
% Calculer la moyenne de la norme de l'acc. 3D pdt le 6MWT (reference)
% -------------------------------------------------------------------------
figure(); hold on; box on; grid on;
title('Sélectionnez la zone correspondant au 6MWT');
plot(data_6MWT.AccNORM);
time_6MWT = ginput(2); % Définir la zone d'acquisition du 6MWT
data_6MWT.ref_6MWT  = mean(data_6MWT.AccNORM(round(time_6MWT(1,1):...
                                             round(time_6MWT(2,1)))));

% -------------------------------------------------------------------------                                           
% Sauvegarder les données
% -------------------------------------------------------------------------
close all;
folder = uigetdir('','Sélectionner le répertoire de destination du fichier de sauvegarde');
cd(folder);
save([patient.lastname,'_',...
      patient.firstname,'_',...
      patient.dateofbirth,'_',...
      '6MWT_',regexprep(data_6MWT.Date,'/',''),'.mat'],'data_6MWT');
cd(toolboxFolder);