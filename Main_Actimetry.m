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
warning('off');
clc;

disp('Bienvenue Cher Ma�tre V�n�rable !');
disp(' ');

% -------------------------------------------------------------------------
% D�finir le patient
% -------------------------------------------------------------------------
type = input('>>> Importation de fichiers (1) ou uniquement affichage de r�sultats (2)? ','s');
if strcmp(type,'1')
    patient.lastname  = input('- Nom du patient : ','s');
    patient.firstname = input('- Pr�nom du patient : ','s');
    patient.dateofbirth = input('- Date de naissance du patient (JJMMAAAA) : ','s');
end

% -------------------------------------------------------------------------
% Importer les donn�es du 6MWT
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des donn�es du 6MWT');
if strcmp(type,'1')
    temp = input('- Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        get_6MWT_data(patient,toolboxFolder);
        disp('- Fichier 6MWT import�');
    else
        disp('- Aucun fichier import�');
    end
else
    disp('Aucun fichier import�');
end

% -------------------------------------------------------------------------
% Importer les donn�es de mesure
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Importation des donn�es de mesure patient');
if strcmp(type,'1')
    temp = input('- Nouvelle importation? (OUI/NON) : ','s');
    if strcmp(temp,'OUI')
        nfile = input('- Combien de fichiers � importer? : ');
        get_Mes_data(patient,toolboxFolder,nfile);
        disp(['- ',num2str(nfile),' fichier(s) de mesures import�(s)']);
    else
        disp('Aucun fichier import�');
    end
else
    disp('Aucun fichier import�');
end

% -------------------------------------------------------------------------
% Afficher les r�sultats
% -------------------------------------------------------------------------
clear temp;
disp(' '); disp('>>> Affichage des r�sultats');
plot_result();