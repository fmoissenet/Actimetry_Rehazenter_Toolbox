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

function plot_result(data_Mes)
                 
figure(); hold on; box on; grid on;
title('R�sultats normalis�s');
xlabel(['Temps (1 unit� = ',data_Mes.Epoch,' s)']);
ylabel('Quantit� de mouvement (%6MWT)');
for i = 1:length(data_Mes)
    plot(data_Mes(i).quantiteM_norm);
    legend(['Test du ',data_Mes(i).Date]);
end