clear;
close all;

%% Load ellipses.txt
ellipses = fopen('ellipses.txt','r');

parametres_ell = fscanf(ellipses,'%f', [7 Inf]);
parametres_ell = parametres_ell';
parametres_ell(1,:)
fclose(ellipses);

[~,index]= sortrows(round(parametres_ell/50),[1 2]);
parametres_ell = parametres_ell(index,:);
%% Filtrage des ellipses ayant un angle < 4.7 (radian)

angle = abs(parametres_ell(:,7)-parametres_ell(:,6));
% [indices] = find(angle > 4.7);
% angle = angle(indices);
% parametres_ell = parametres_ell(indices,:);

%% Paramètres de l'ellipse
% Grand-axe
a = parametres_ell(:,3);
% Petit-axe
b = parametres_ell(:,4);
psi = parametres_ell(:,5);

e = sqrt(1-(b./a).^2);

%% Calcul des normales
R = 40;

nz = b./R;
nx = sqrt(1-nz.^2)./sqrt(1+tan(psi).^2);
ny = tan(psi).*(sqrt(1-nz.^2)./(1+tan(psi).^2));
% Solution 1
N1 = [nx,ny,nz];
% Solution 2
N2 = [-nx,-ny,nz];

%norme = sqrt(nz.^2+nx.^2+ny.^2)
%% Intégration du champ de normales :

p_estime = reshape(-nx'./nz',[19, 19]);
size(p_estime)
q_estime = reshape(-ny'./nz',[19, 19]);
z_estime = integration_SCS(q_estime,p_estime);
z_estime = z_estime(:);

%% Retour graphique
figure(1);
scatter((1:length(angle))',angle');

figure(2);
scatter(parametres_ell(:,1), parametres_ell(:,2));
ylim([0 2654]);
xlim([0 1998]);
% 
% figure(3);
% quiver3(parametres_ell(:,1), parametres_ell(:,2), zeros(size(nx)), nx, ny, nz);
% axis equal
% 
% figure(4);
% quiver3(parametres_ell(:,1), parametres_ell(:,2), zeros(size(nx)), -nx, -ny, nz);
% axis equal

figure(5);
scatter3(parametres_ell(:,1), parametres_ell(:,2),z_estime);

figure(6);
x = parametres_ell(:,1);
y = parametres_ell(:,2);
z = z_estime;
stem3(x, y ,z);

figure(7);
grid on
xv = linspace(min(x), max(x), 20);
yv = linspace(min(y), max(y), 20);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);

quiver3(x, y, z, nx, ny, nz)
hold on
surf(X,Y,Z)

grid on
set(gca, 'ZLim',[0 100])
shading interp