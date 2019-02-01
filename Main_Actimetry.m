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

disp('Bienvenue Cher Ma�tre V�n�rable !');

% -------------------------------------------------------------------------
% Importer les donn�es du 6MWT
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des donn�es du 6MWT');
temp = input('- Nouvelle importation? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    patient.lastname  = input('- Nom du patient : ','s');
    patient.firstname = input('- Pr�nom du patient : ','s');
    patient.dateofbirth = input('- Date de naissance du patient (JJMMAAAA) : ','s');
    get_6MWT_data(patient,toolboxFolder);
    disp('- Fichier 6MWT import�');
else
    disp('- Aucun fichier import�');
end

% -------------------------------------------------------------------------
% Importer les donn�es de mesure
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des donn�es de mesure patient');
temp = input('- Nouvelle importation? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    if isempty(patient)
        patient.lastname  = input('- Nom du patient : ','s');
        patient.firstname = input('- Pr�nom du patient : ','s');
        patient.dateofbirth = input('- Date de naissance du patient (JJMMAAAA) : ','s');
    end
    nfile = input('- Combien de fichiers � importer? : ');
    get_Mes_data(patient,toolboxFolder,nfile);
    disp(['- ',num2str(nfile),' fichier(s) de mesures import�(s)']);
else
    disp('- Aucun fichier import�');
end

% -------------------------------------------------------------------------
% Afficher les r�sultats
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Affichage des r�sultats');
temp = input('- Affichage des r�sultats? (OUI/NON) : ','s');
if strcmp(temp,'OUI')
    plot_result();
else
    disp('- Aucun affichage demand�');
end