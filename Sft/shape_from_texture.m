clear;
close all;

load("../Generation_synthese/data.mat");
%% Load ellipses.txt
ellipses = fopen('ELSD2/ellipses.txt','r');

parametres_ell = fscanf(ellipses,'%f', [7 Inf]);
parametres_ell = parametres_ell';
fclose(ellipses);


%Plus proche voisin
[l,L] = size(centrex);
list = [];
for i = 1:l
    for j = 1:L
        [~,index] = min(sqrt((parametres_ell(:,1)-centrex(i,j)).^2+(parametres_ell(:,2)-centrey(i,j)).^2));
        list = [list; index];
    end
end

%[~,index]= sortrows(round(parametres_ell/100),[1 2]);
parametres_ell = parametres_ell(list,:);
%% Filtrage des ellipses ayant un angle < 4.7 (radian)

angle = abs(parametres_ell(:,7)-parametres_ell(:,6));
% [indices] = find(angle > 4.7);
% angle = angle(indices);
% parametres_ell = parametres_ell(indices,:);

%% Paramètres de l'ellipse
% Grand-axe
x_terrain = parametres_ell(:,1);
y_terrain = parametres_ell(:,2);

a = parametres_ell(:,3);
% Petit-axe
b = parametres_ell(:,4);
psi = parametres_ell(:,5)-pi/2;
e = sqrt(1-(b./a).^2);

%% Calcul des normales
R = 40;

nz = b./R;
nx = sqrt(1-nz.^2)./sqrt(1+tan(psi).^2);
ny = tan(psi).*(sqrt(1-nz.^2)./(1+tan(psi).^2));
nx = -nx;
ny = -ny;
% Solution vecteurs aléatoires
% v = rand(size(nx));
% nx(v < 0.5) = -nx(v < 0.5);
% ny(v < 0.5) = -ny(v < 0.5);
% Solution cas vecteurs positifs
N1 = [nx,ny,nz];
% Solution cas vecteurs negatifs
N2 = [-nx,-ny,nz];

%norme = sqrt(nz.^2+nx.^2+ny.^2)
%% Intégration du champ de normales :

griddata(x_terrain,y_terrain,-nx./nz,centrex,centrey)
p_estime = reshape(-nx'./nz',[19, 19]);

q_estime = reshape(-ny'./nz',[19, 19]);
z_estime = integration_SCS(q_estime,p_estime);
z_estime = z_estime(:)*5;

%% Retour graphique
figure(1);
scatter((1:length(angle))',angle');

figure(2);
scatter(parametres_ell(:,1), parametres_ell(:,2));
ylim([0 2000]);
xlim([0 2000]);
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

quiver3(x, y, z, nx, ny, nz, 0.1)
hold on
surf(X,Y,Z)

grid on
set(gca, 'ZLim',[min(z) max(z)])
shading interp

save normal N1 N2 parametres_ell;