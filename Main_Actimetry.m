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

disp('Bienvenue Cher Ma�tre V�n�rable !');
disp(' ');

% -------------------------------------------------------------------------
% D�finir le patient
% -------------------------------------------------------------------------
temp1 = input('>>> Importation de fichiers (1) ou uniquement affichage de r�sultats (2)? ','s');
if strcmp(temp1,'1')
    patient.lastname  = input('Nom du patient : ','s');
    patient.firstname = input('Pr�nom du patient : ','s');
    patient.dateofbirth = input('Date de naissance du patient (JJMMAAAA) : ','s');
end

% -------------------------------------------------------------------------
% Importer les donn�es du 6MWT
% -------------------------------------------------------------------------
disp(' '); disp('>>> Importation des donn�es du 6MWT');
if strcmp(temp1,'1')
    temp = input('Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        data_6MWT = get_6MWT_data(patient);
    else
        file = uigetfile('*.mat', 'S�lectionnez le fichier 6MWT requis');
        load(file);
    end
else
    file = uigetfile('*.mat', 'S�lectionnez le fichier 6MWT requis');
    load(file);
end

% -------------------------------------------------------------------------
% Importer les donn�es de mesure
% -------------------------------------------------------------------------
disp(' '); disp('>>> Importation des donn�es de mesure patient');
if strcmp(temp1,'1')
    temp = input('Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        data_Mes = get_Mes_data(patient,data_6MWT);
    end
    temp = input('Souhaitez-vous ouvrir plusieurs fichiers de mesure? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        clear data_Mes;
        file = uigetfile('*.mat', 'S�lectionnez les fichiers de mesure requis','MultiSelect','on');
        for i = 1:length(file)
            data_Mes(i) = load(file);
        end
    end
else
    file = uigetfile('*.mat', 'S�lectionnez les fichiers de mesure requis','MultiSelect','on');
    for i = 1:length(file)
        data_Mes(i) = load(file);
    end
end

% -------------------------------------------------------------------------
% Afficher les r�sultats
% -------------------------------------------------------------------------
disp(' '); disp('>>> Affichage des r�sultats');
plot_result(data_Mes);