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
% S�lection les fichiers
% -------------------------------------------------------------------------
% Ouvrir le fichier 6MWT de r�f�rence
[file,folder] = uigetfile('*_6MWT*.mat', 'S�lectionnez le fichier 6MWT requis');
load([folder,file]);
% Ouvrir le ou les fichiers de mesures
[file,folder] = uigetfile('*.mat', 'S�lectionnez les fichiers de mesure requis','MultiSelect','on');
if iscell(file) % Test : si 1 fichier, file est un "char" sinon un "cell"
    n = size(file,2);
else
    n = 1;
end

% -------------------------------------------------------------------------
% Pr�parer la figure
% -------------------------------------------------------------------------
figure();

% -------------------------------------------------------------------------
% Traiter chaque fichiers s�lectionn�s
% -------------------------------------------------------------------------
for ifile = 1:n
    
    % Charger les donn�es
    clear data_Mes;
    if n == 1 % Test : si 1 fichier, file est un "char" sinon un "cell"
        load([folder,file]);
    else
        load([folder,file{ifile}]);
    end
    
    % Pr�parer l'affichage du graphique
    subplot(n,1,ifile); hold on; box on; grid on;
    title(['Test du ',data_Mes.Date]);
    
    % Pr�parer l'affichage HH:MM
    hour = str2num(data_Mes.Hour);
    minute = str2num(data_Mes.Min);
    minVal = [0:1:round(size(data_Mes.AccNORM,1)/(60/str2num(data_Mes.Epoch)))];
    for i = minVal
        tminute = minute+i;
        thour = hour;
        % Gestion du passage d'heure 
        extra = fix(tminute/60);
        if extra >= 1           
            tminute = tminute-60*fix(tminute/60);
        end
        thour = thour+extra;
        % Gestion du passage de jour
        if thour > 24 
            thour = thour-24;
        end
        % Gestion de l'affichage des minutes
        if tminute < 10
            hourVal{i+1} = [num2str(thour),':0',num2str(tminute)];
        else
            hourVal{i+1} = [num2str(thour),':',num2str(tminute)];
        end
    end
    
    % Adapter les donn�es en fonction de l'interval de temps souhait�
    j = 1;
    for i = 1:interval:length(minVal)
        xVal(j) = minVal(i)*size(data_Mes.AccNORM,1)/length(minVal);
        xLab{j} = hourVal{i};
        j = j+1;
    end
    
    % Tracer les mesures
    xticks(xVal);
    xticklabels(xLab);
    xtickangle(90);
    xlabel(['Temps (interval de ',num2str(interval),' min)']);
    ylabel('Intensit� de l''activit� (%6MWT)');
    AccNORM_norm = data_Mes.AccNORM/round(data_6MWT.ref_6MWT)*100; % %6MWT
    plot(AccNORM_norm);
    
end