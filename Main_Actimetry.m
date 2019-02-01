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

clearvars;
close all;
toolboxFolder = 'C:\Users\florent.moissenet\Documents\Professionnel\routines\github\Actimetry_Rehazenter_Toolbox';
addpath(toolboxFolder);
patient = [];
warning('off');
clc;

disp('Bienvenue Cher Maître Vénérable !');

% -------------------------------------------------------------------------
% Importer les données du 6MWT
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des données du 6MWT');
temp = input('- Nouvelle importation? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    patient.lastname  = input('- Nom du patient : ','s');
    patient.firstname = input('- Prénom du patient : ','s');
    patient.dateofbirth = input('- Date de naissance du patient (JJMMAAAA) : ','s');
    get_6MWT_data(patient,toolboxFolder);
    disp('- Fichier 6MWT importé');
else
    disp('- Aucun fichier importé');
end

% -------------------------------------------------------------------------
% Importer les données de mesure
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des données de mesure patient');
temp = input('- Nouvelle importation? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    if isempty(patient)
        patient.lastname  = input('- Nom du patient : ','s');
        patient.firstname = input('- Prénom du patient : ','s');
        patient.dateofbirth = input('- Date de naissance du patient (JJMMAAAA) : ','s');
    end
    nfile = input('- Combien de fichiers à importer? : ');
    get_Mes_data(patient,toolboxFolder,nfile);
    disp(['- ',num2str(nfile),' fichier(s) de mesures importé(s)']);
else
    disp('- Aucun fichier importé');
end

% -------------------------------------------------------------------------
% Afficher les résultats
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Affichage des résultats');
temp = input('- Affichage des résultats? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    plot_result();
else
    disp('- Aucun affichage demandé');
end