close all;

%% Constante
n = 2000; % Taille de l'image / nombre de points
m = 100; % Nombre de cercles
R = .1;
pas = 100;

%[X,Y,Z] = peaks(n);
f = @(x,y) (x + y.^2) *0.5;
p = -2.5;
q = 2.5;

[X,Y] = meshgrid(linspace(p,q,n));
Z = f(X,Y);

% Image
im = 255*ones(n);
[Nx,Ny,Nz] = surfnorm(X,Y,Z);
[centrey,centrex]= meshgrid(100:pas:n-100,100:pas:n-100);
%% Algo
for k=100:pas:n-100
    for h=100:pas:n-100
        % Entier 1 à 500
        % centre = round(rand([1,2])*n);
        xc = k; % centre(1);
        yc = h; % centre(2);
        im(xc,yc) = 0;
        
        n_barre = [Nx(xc,yc),Ny(xc,yc)];
        a = R;
        b = R*Nz(xc,yc);
        psi = atan(Ny(xc,yc)/Nx(xc,yc)) + pi/2;
        
        %j = meshgrid(1:n,1:n);
        %i = j';
        
        x = X(xc,yc);
        y = Y(xc,yc);
        for i=1:n
            for j=1:n
                x_t = X(i,j);
                y_t = Y(i,j);
        
                u = (x_t-x)*cos(psi) + (y_t-y)*sin(psi);
                v = (x_t-x)*sin(psi) - (y_t-y)*cos(psi);
                
                if u^2/(a^2) + v^2/(b^2) <= 1
                    im(n-i+1,j) = 0;
                end
            end
        end
    end
end

figure();
imshow(im);
imsave

figure(); 
campos([0 0 10]);
surf(X,Y,Z,'EdgeColor','None');
hold on
plot3(X(xc,yc),Y(xc,yc),Z(xc,yc),'r*');

save data.mat centrex centrey Nx Ny Nz;