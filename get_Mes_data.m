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

function data_Mes = get_Mes_data(patient,data_6MWT)

% -------------------------------------------------------------------------
% Importer les mesures patient
% -------------------------------------------------------------------------
[file,folder] = uigetfile('*.csv', 'Sélectionnez le fichier correspondant aux mesures patient');
data_Mes = importdata([folder,file],',');

% -------------------------------------------------------------------------
% Extraire les metadata concernant les mesures
% -------------------------------------------------------------------------
temp1            = data_Mes.textdata{2,1};
temp2            = data_Mes.textdata{4,1};
temp3            = data_Mes.textdata{5,1};
data_Mes.SN      = temp1(16:end);
data_Mes.File    = file;
data_Mes.Date    = temp2(12:end);
data_Mes.Epoch   = temp3(31:end);
data_Mes.Ref6MWT = data_6MWT.ref_6MWT;

% -------------------------------------------------------------------------
% Extraire les données des mesures sur patient
% -------------------------------------------------------------------------
data_Mes.AccX        = data_Mes.data(:,1); % Acceleration mesurée /X , m.s-2
data_Mes.AccY        = data_Mes.data(:,2); % Acceleration mesurée /Y , m.s-2
data_Mes.AccZ        = data_Mes.data(:,3); % Acceleration mesurée /Z , m.s-2
data_Mes.Step        = data_Mes.data(:,4); % Nombre de pas mesurés   , adim
data_Mes.Lux         = data_Mes.data(:,5); % Eclairement mesurés     , lux
data_Mes.IncOff      = data_Mes.data(:,6); % Aucune position mesurée , s
data_Mes.IncStanding = data_Mes.data(:,7); % Temps en position debout, s
data_Mes.IncSitting  = data_Mes.data(:,8); % Temps en position assise, s
data_Mes.IncLying    = data_Mes.data(:,9); % Temps de position alongé, s

% -------------------------------------------------------------------------
% Calculer la quantité de mouvement (norme de l'accélération 3D)
% -------------------------------------------------------------------------
data_Mes.quantiteM = sqrt(data_Mes.AccX.^2 + ...
                          data_Mes.AccY.^2 + ...
                          data_Mes.AccZ.^2); % m.s-2
                      
% -------------------------------------------------------------------------
% Normaliser la quantité de mouvement / moyenne obtenue au 6MWT
% -------------------------------------------------------------------------
data_Mes.quantiteM_norm = data_Mes.quantiteM/round(data_Mes.Ref6MWT)*100; % %6MWT

% -------------------------------------------------------------------------
% Sauvegarder les données
% -------------------------------------------------------------------------
save([patient.lastname,'_',...
      patient.firstname,'_',...
      patient.dateofbirth,'_',...
      'Mes_',regexprep(data_Mes.Date,'/',''),'.mat'],'data_Mes');