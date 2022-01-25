close all;

% Normales du modèle, ground truth
N = [N_x(:) N_y(:) N_z(:)];
% Vecteur d'éclairage
s = [0 1 -1];

% Shape from shading
I = N*s'/norm(s);
I1 = -N1*s'/norm(s);
I2 = -N2*s'/norm(s);

ind = sub2ind(size(N_x),centrex(:),centrey(:));

% MSE
r1 = (I(ind)-I1).^2;
r2 = (I(ind)-I2).^2;

% Vecteur 1 -> N1 ; -1 -> N2
v = ones(size(r1));
v(r2 < r1) = -1;

sol = reshape(v,size(centrex));

% Champ de normales final 
N_final = N1;
N_final(v == -1,:) = N2(v == -1,:);

shading_final = -N_final*s'/norm(s);