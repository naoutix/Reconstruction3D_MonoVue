clear;
close all;


%% Chargement

% Load ellipses.txt
ellipses = fopen('ellipses.txt','r');

parametres_ell = fscanf(ellipses,'%f', [7 Inf]);
parametres_ell = parametres_ell';
parametres_ell(1,:)
fclose(ellipses);

%% Parametre
% Calcul excentricité des ellipses
e = [];
% Grand-axe
a = parametres_ell(:,3);
% Petit-axe
b = parametres_ell(:,4);

e = sqrt(1-(b./a).^2);

figure(1);
scatter((1:length(e))',abs(parametres_ell(:,6)-parametres_ell(:,5))');

figure(2);
scatter(parametres_ell(:,2), parametres_ell(:,1));
ylim([0 2654]);
xlim([0 1998]);

%% Calcul des normales
%% SFS
%% Calcul des profondeur