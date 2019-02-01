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
% Préparer la figure
% -------------------------------------------------------------------------
figure(); hold on; box on; grid on;
title('Résultats normalisés');

% -------------------------------------------------------------------------
% Trouver la plus longue mesure (en temps)
% -------------------------------------------------------------------------
maxMes = 0;
imaxMes = [];
for i = 1:length(data_Mes)
    if size(data_Mes(i).AccNORM,1) > maxMes
        imaxMes = i;
    end
end

% -------------------------------------------------------------------------
% Préparer l'affichage HH:MM
% -------------------------------------------------------------------------
minVal = [1:1:round(size(data_Mes(imaxMes).AccNORM,1)/(60/str2num(data_Mes(imaxMes).Epoch)))];
for i = 1:length(minVal)
    clear temp;
    start = str2num(data_Mes(imaxMes).Stime);
    if minVal(i) >= 60
        start = start+1; % Gestion du passage d'heure
        if start > 24    % Gestion du passage de jour
            start = 1;
        end
        temp = minVal(i)-60;
    else
        temp = minVal(i);
    end
    if temp < 10
        hourVal{i} = [num2str(start),':0',num2str(temp-1)];
    else
        hourVal{i} = [num2str(start),':',num2str(temp-1)];
    end
end

% -------------------------------------------------------------------------
% Adapter les données en fonction de l'interval de temps souhaité
% -------------------------------------------------------------------------
j = 1;
for i = 1:interval:length(minVal)
    xVal(j) = minVal(i)*size(data_Mes(imaxMes).AccNORM,1)/length(minVal);
    xLab{j} = hourVal{i};
    j = j+1;
end

% -------------------------------------------------------------------------
% Tracer les mesures
% -------------------------------------------------------------------------
xticks(xVal);
xticklabels(xLab);
xtickangle(90);
xlabel(['Temps (interval de ',num2str(interval),' min)']);
ylabel('Intensité de l''activité (%6MWT)');
legends = {};
for i = 1:length(data_Mes)
    clear AccNORM_norm;
    AccNORM_norm = data_Mes(i).AccNORM/round(data_6MWT.ref_6MWT)*100; % %6MWT
    plot(AccNORM_norm);
    legends = [legends ['Test du ',data_Mes(i).Date]];
end
legend(legends);