clear;
close all;

% Load ellipses.txt
ellipses = fopen('ellipses.txt','r');

parametres_ell = fscanf(ellipses,'%f', [7 Inf]);
parametres_ell = parametres_ell';
parametres_ell(1,:)
fclose(ellipses);

% Filtrage des ellipses ayant un angle < 4.7 (radian)
angle = abs(parametres_ell(:,7)-parametres_ell(:,6));
[indices] = find(angle > 4.7);
angle = angle(indices);

figure(1);
scatter((1:length(angle))',angle');

% Calcul excentricité des ellipses
parametres_ell = parametres_ell(indices,:);
e = [];
% Grand-axe
a = parametres_ell(:,3);
% Petit-axe
b = parametres_ell(:,4);

e = sqrt(1-(b./a).^2);

figure(2);
scatter(parametres_ell(:,2), parametres_ell(:,1));
ylim([0 2654]);
xlim([0 1998]);

% Calcul des normales
R = 40;
psi = parametres_ell(:,5);

nz = b./R;
nx = sqrt(1-nz.^2)./sqrt(1+tan(psi).^2);
ny = tan(psi).*(sqrt(1-nz.^2)./(1+tan(psi).^2));

figure(3);
quiver3(parametres_ell(:,1), parametres_ell(:,2), zeros(size(nx)), nx, ny, nz);
axis equal

figure(4);
quiver3(parametres_ell(:,1), parametres_ell(:,2), zeros(size(nx)), -nx, -ny, nz);
axis equal

% Intégration du champ de normales :

% p_estime = reshape(-nx'./nz,size(masque));
% p_estime(exterieur) = 0;
% q_estime = reshape(-ny'./nz',size(masque));
% q_estime(exterieur) = 0;
% z_estime = integration_SCS(q_estime,p_estime);




