clear;
close all;
load normal.mat;
load '../Generation_synthese/data.mat';
% Normales du modèle, ground truth
N_x = Nx;
N_y = Ny;
N_z = Nz;
N = [N_x(:) N_y(:) N_z(:)];
% Vecteur d'éclairage
s = [0 1 -1];

% Shape from shading
I = N*s'/norm(s);
I1 = -N1*s'/norm(s);
I2 = -N2*s'/norm(s);

ind = sub2ind(size(N_x),centrex(:),centrey(:));

% MSE
r1 = sqrt((I(ind)-I1).^2);
r2 = sqrt((I(ind)-I2).^2);

% Vecteur 1 -> N1 ; -1 -> N2
v = ones(size(r1));
v(r2 > r1) = -1;

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

% Affichage graphique
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

size(z)
size(N_final(3))
quiver3(x, y, z, nx, ny, nz, 0.2);
hold on
surf(X,Y,Z)