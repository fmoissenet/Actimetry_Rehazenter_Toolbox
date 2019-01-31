% =========================================================================
% REHAZENTER ACTIMETRY TOOLBOX
% =========================================================================
% File name:    plot_results
% -------------------------------------------------------------------------
% Subject:      Plot actimetry measurements
% -------------------------------------------------------------------------
% Author: F. Moissenet, G. Areno
% Date of creation: 31/01/2019
% Version: 1
% =========================================================================

function plot_result()
        
% -------------------------------------------------------------------------
% S�lection les fichiers
% -------------------------------------------------------------------------
% Ouvrir le fichier 6MWT
[file,folder] = uigetfile('*.mat', 'S�lectionnez le fichier 6MWT requis');
load([folder,file]);
% Ouvrir le ou les fichiers de mesures
[file,folder] = uigetfile('*.mat', 'S�lectionnez les fichiers de mesure requis','MultiSelect','on');
if iscell(file) % Test : si 1 fichier, file est un "char" sinon un "cell"
    n = size(file,2);
else
    n = 1;
end
for i = 1:n
    if n == 1 % Test : si 1 fichier, file est un "char" sinon un "cell"
        load([folder,file]);
    else
        load([folder,file{i}]);
    end
    temp(i) = data_Mes;
    clear data_Mes;
end
data_Mes = temp;

% -------------------------------------------------------------------------
% Afficher les r�sultats
% -------------------------------------------------------------------------
figure(); hold on; box on; grid on;
title('R�sultats normalis�s');
xlabel(['Temps (1 unit� = ',data_Mes(1).Epoch,' s)']);
ylabel('Quantit� de mouvement (%6MWT)');
legends = {};
for i = 1:length(data_Mes)
    clear quantiteM_norm;
    % Normaliser la quantit� de mouvement / moyenne obtenue au 6MWT
    quantiteM_norm = data_Mes(i).quantiteM/round(data_6MWT.ref_6MWT)*100; % %6MWT
    plot(quantiteM_norm);
    legends = [legends ['Test du ',data_Mes(i).Date]];
end
legend(legends);