% =========================================================================
% ACTIMETRY REHAZENTER TOOLBOX
% =========================================================================
% File name:    Main_Actimetry
% -------------------------------------------------------------------------
% Subject:      Toolbox launcher
% -------------------------------------------------------------------------
% Authors: F. Moissenet, G. Areno
% Date of creation: 31/01/2019
% Version: 1
% =========================================================================

clearvars
close all
clc

disp('Bienvenue Cher Maître Vénérable !');
disp(' ');

% -------------------------------------------------------------------------
% Définir le patient
% -------------------------------------------------------------------------
temp1 = input('>>> Importation de fichiers (1) ou uniquement affichage de résultats (2)? ','s');
if strcmp(temp1,'1')
    patient.lastname  = input('Nom du patient : ','s');
    patient.firstname = input('Prénom du patient : ','s');
    patient.dateofbirth = input('Date de naissance du patient (JJMMAAAA) : ','s');
end

% -------------------------------------------------------------------------
% Importer les données du 6MWT
% -------------------------------------------------------------------------
disp(' '); disp('>>> Importation des données du 6MWT');
if strcmp(temp1,'1')
    temp = input('Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        data_6MWT = get_6MWT_data(patient);
    else
        file = uigetfile('*.mat', 'Sélectionnez le fichier 6MWT requis');
        load(file);
    end
else
    file = uigetfile('*.mat', 'Sélectionnez le fichier 6MWT requis');
    load(file);
end

% -------------------------------------------------------------------------
% Importer les données de mesure
% -------------------------------------------------------------------------
disp(' '); disp('>>> Importation des données de mesure patient');
if strcmp(temp1,'1')
    temp = input('Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        data_Mes = get_Mes_data(patient,data_6MWT);
    end
    temp = input('Souhaitez-vous ouvrir plusieurs fichiers de mesure? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        clear data_Mes;
        file = uigetfile('*.mat', 'Sélectionnez les fichiers de mesure requis','MultiSelect','on');
        for i = 1:length(file)
            data_Mes(i) = load(file);
        end
    end
else
    file = uigetfile('*.mat', 'Sélectionnez les fichiers de mesure requis','MultiSelect','on');
    for i = 1:length(file)
        data_Mes(i) = load(file);
    end
end

% -------------------------------------------------------------------------
% Afficher les résultats
% -------------------------------------------------------------------------
disp(' '); disp('>>> Affichage des résultats');
plot_result(data_Mes);