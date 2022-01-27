clear all;
close all;
load '../data/normalSft.mat';
load '../data/data.mat';

%% Constante
% Normales du modèle, ground truth
N = [Nx(:) Ny(:) Nz(:)];

% Sft
NPlus = N1;
NMoins = N2;
% Vecteur d'éclairage
s = [0 0.5 1];

%% Shape from shading
I = N*s'/norm(s);
I1 = NPlus*s'/norm(s);
I2 = NMoins*s'/norm(s);

ind = sub2ind(size(Nx),centrex(:),centrey(:));
% MSE
r1 = sqrt((I(ind)-I1).^2);
r2 = sqrt((I(ind)-I2).^2);

% Vecteur 1 -> N1 ; -1 -> N2
v = ones(size(r1));
v(r2 < r1) = -1;

%% Shading reconstitué
I_final = I1;
I_final(v == -1) = I2(v == -1);
figure;
imshow(reshape(I_final,19,19));
sol = reshape(v,size(centrex));

% Champ de normales final 
N_final = N1;
N_final(v == -1,:) = N2(v == -1,:);

shading_final = -N_final*s'/norm(s);

% Intégration du champ de normales :
nx = N_final(:,1);
ny = N_final(:,2);
nz = N_final(:,3);

p_estime = reshape(-nx'./nz',[19, 19]);
size(p_estime)
q_estime = reshape(-ny'./nz',[19, 19]);
z_estime = integration_SCS(q_estime,p_estime);
z_estime = z_estime(:)*5;

%% Affichage graphique
figure;
imshow(reshape(I,2000,2000))

x = parametres_ell(:,1);
y = parametres_ell(:,2);
z = z_estime;

figure();
grid on
xv = linspace(min(x), max(x), 20);
yv = linspace(min(y), max(y), 20);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);

quiver3(x, y, z, nx, ny, nz, 0.08);
hold on
surf(X,Y,Z)