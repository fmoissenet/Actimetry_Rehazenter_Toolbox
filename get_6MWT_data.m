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
[file,folder] = uigetfile('*_6MWT*.csv', 'S�lectionnez le fichier correspondant au test de 6 minutes');
data_6MWT     = importdata([folder,file],',');

% -------------------------------------------------------------------------
% Extraire les metadata concernant le 6MWT
% -------------------------------------------------------------------------
temp1             = data_6MWT.textdata{2,1};
temp2             = data_6MWT.textdata{4,1};
temp3             = data_6MWT.textdata{5,1};
data_6MWT.SN      = temp1(16:end);
data_6MWT.File    = file;
data_6MWT.Date    = temp2(12:end);
data_6MWT.Epoch   = temp3(31:end);
data_6MWT.Ref6MWT = [];
clear temp1 temp2 temp3;

% -------------------------------------------------------------------------
% Extraire les donn�es du 6 minutes (acc�l�rations uniquement)
% -------------------------------------------------------------------------
data_6MWT.AccX = data_6MWT.data(:,1); % Acceleration mesur�e /X , m.s-2
data_6MWT.AccY = data_6MWT.data(:,2); % Acceleration mesur�e /Y , m.s-2
data_6MWT.AccZ = data_6MWT.data(:,3); % Acceleration mesur�e /Z , m.s-2

% -------------------------------------------------------------------------
% Calculer la moyenne de la quantit� de mouvement pdt le 6MWT (reference)
% -------------------------------------------------------------------------
data_6MWT.quantiteM = sqrt(data_6MWT.AccX.^2 + ...
                           data_6MWT.AccY.^2 + ...
                           data_6MWT.AccZ.^2); % m.s-2
figure(); hold on; box on; grid on;
title('S�lectionnez la zone correspondant au 6MWT');
plot(data_6MWT.quantiteM);
time_6MWT = ginput(2); % D�finir la zone d'acquisition du 6MWT
data_6MWT.ref_6MWT  = mean(data_6MWT.quantiteM(round(time_6MWT(1,1):...
                                               round(time_6MWT(2,1)))));

% -------------------------------------------------------------------------                                           
% Sauvegarder les donn�es
% -------------------------------------------------------------------------
close all;
folder = uigetdir('','S�lectionner le r�pertoire de destination du fichier de sauvegarde');
cd(folder);
save([patient.lastname,'_',...
      patient.firstname,'_',...
      patient.dateofbirth,'_',...
      '6MWT_',regexprep(data_6MWT.Date,'/',''),'.mat'],'data_6MWT');
cd(toolboxFolder);