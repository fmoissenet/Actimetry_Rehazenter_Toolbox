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

function plot_result(interval)

% -------------------------------------------------------------------------
% Sélection les fichiers
% -------------------------------------------------------------------------
% Ouvrir le fichier 6MWT
[file,folder] = uigetfile('*_6MWT*.mat', 'Sélectionnez le fichier 6MWT requis');
load([folder,file]);
% Ouvrir le ou les fichiers de mesures
[file,folder] = uigetfile('*.mat', 'Sélectionnez les fichiers de mesure requis','MultiSelect','on');
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
% Afficher les résultats bruts
% -------------------------------------------------------------------------
figure(); hold on; box on; grid on;
title('Résultats normalisés');
% Trouver la plus longue mesure
maxMes = 0;
imaxMes = [];
for i = 1:length(data_Mes)
    if size(data_Mes(i).quantiteM,1) > maxMes
        imaxMes = i;
    end
end
% Préparer l'affichage HH:MM
minVal = [1:1:round(size(data_Mes(imaxMes).quantiteM,1)/(60/str2num(data_Mes(imaxMes).Epoch)))];
for i = 1:length(minVal)
    start = str2num(data_Mes(imaxMes).Stime);
    if minVal(i) >= 60
        start = start+1;
        minVal(i) = minVal(i)-60;
    end
    hourVal{i} = [num2str(start),':',num2str(minVal(i))];
end
% Adapter en fonction de l'interval de temps souhaité
minVal = [1:1:round(size(data_Mes(imaxMes).quantiteM,1)/(60/str2num(data_Mes(imaxMes).Epoch)))];
j = 1;
for i = 1:interval:length(minVal)
    xVal(j) = minVal(i)*size(data_Mes(imaxMes).quantiteM,1)/length(minVal);
    xLab{j} = hourVal{i};
    j = j+1;
end
% Afficher les résultats
xticks(xVal);
xticklabels(xLab);
xtickangle(90);
xlabel(['Temps (interval de ',num2str(interval),' min)']);
ylabel('Quantité de mouvement (%6MWT)');
legends = {};
for i = 1:length(data_Mes)
    clear quantiteM_norm;
    % Normaliser la quantité de mouvement / moyenne obtenue au 6MWT
    quantiteM_norm = data_Mes(i).quantiteM/round(data_6MWT.ref_6MWT)*100; % %6MWT
    plot(quantiteM_norm);
    legends = [legends ['Test du ',data_Mes(i).Date]];
end
legend(legends);