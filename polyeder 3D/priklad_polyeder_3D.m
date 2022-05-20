clc;
close all;
clear all;

%% Predpoklady
% startovaci bod
x0 = [2;2;0.8];

% toleracna konstanta epsilon
eps = 1e-6;

% maximalny pocet iteracii
n = 100;

% rozmer ulohy
d = 3;

% MAP - uhol pi/4
% ohranicenia
G1 =[-1   1  -1;
      1   1  -1;
      1  -1  -1;
     -1  -1  -1;
      0   0   1];

% ohranicenie rovinou a^Tx = b
a = [0;0;1];
sz = size(G1);
sz = sz(1);
c1 = [zeros(sz-1,1);2];

% pomocna matica na vykreslenie
H1 = [0 -2  2;
     -2  0  2;
      0  2  2;
      2  0  2];
P = [0 0 0; H1];
k = convhulln (P);

% vykreslenie
trisurf(k, P(:,1),P(:,2),P(:,3),'FaceColor',[0.8196,0.9725,1.0000]);
xlim([-4 4]);
ylim([-4 4]);
zlim([0 inf]);
hold on
scatter3(x0(1),x0(2),x0(3),'blue','filled');

[x11,fval11,iter11,t11] = proj3(x0,G1,c1,eps,n,d);
[x12,fval12,iter12,t12] = projquad(x0,G1,c1,a,0,eps,n,d);
[x13,fval13,iter13,t13] = projexpl(x0,G1,c1,a,0,eps,n,d);

x11 = x11';
fval11 = fval11';

fprintf('============================================================================================== \n');
fprintf(' Metoda striedavych projekcii - uhol pi/4\n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('  metoda  |  #iter.  |     x(1)      |     x(2)     |      x(3)     |    fval(k)   |    cas    \n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.6f   |   %4.6f   |  %4.6f    | %4.10f |   %4.4f   \n' ,[iter11;x11(height(x11),:)';fval11(length(fval11));t11]);
fprintf('    QP    |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter12;x12(height(x12),:)';fval12(length(fval12));t12]);
fprintf('   EXPL.  |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter13;x13(height(x13),:)';fval13(length(fval13));t13]);
fprintf('---------------------------------------------------------------------------------------------- \n');

%% MAP - uhol 3pi/8
% ohranicenia
G2 = [G1(:,1),G1(:,2),G1(:,3)/2];
c2 = c1/2;
 
% pomocna matica na vykreslenie
H2 =  [H1(:,1)/2,H1(:,2)/2,H1(:,3)];
P = [0 0 0; H2];
k = convhulln (P);

% vykreslenie
figure(3)
trisurf(k, P(:,1),P(:,2),P(:,3),'FaceColor',[0.8196,0.9725,1.0000]);
xlim([-4 4]);
ylim([-4 4]);
zlim([0 inf]);
hold on
scatter3(x0(1),x0(2),x0(3),'blue','filled');

[x21,fval21,iter21,t21] = proj3(x0,G2,c2,eps,n,d);
[x22,fval22,iter22,t22] = projquad(x0,G2,c2,a,0,eps,n,d);
[x23,fval23,iter23,t23] = projexpl(x0,G2,c2,a,0,eps,n,d);

x21 = x21';
fval21 = fval21';

fprintf('============================================================================================== \n');
fprintf(' Metoda striedavych projekcii - uhol pi/4\n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('  metoda  |  #iter.  |     x(1)      |     x(2)     |      x(3)     |    fval(k)   |    cas    \n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f   | %4.10f |   %4.4f   \n' ,[iter21;x21(height(x21),:)';fval21(length(fval21));t21]);
fprintf('    QP    |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter22;x22(height(x22),:)';fval22(length(fval22));t22]);
fprintf('   EXPL.  |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter23;x23(height(x23),:)';fval23(length(fval23));t23]);
fprintf('---------------------------------------------------------------------------------------------- \n');

%% MAP - uhol pi/8
% ohranicenia
G3 = [G1(:,1),G1(:,2),G1(:,3)*2];
c3 = c1*2;

% pomocna matica na vykreslenie
H3 =  [H1(:,1)*2,H1(:,2)*2,H1(:,3)];
P = [0 0 0; H3];
k = convhulln (P);

% vykreslenie
figure(4)
trisurf(k, P(:,1),P(:,2),P(:,3),'FaceColor',[0.8196,0.9725,1.0000]);
xlim([-4 4]);
ylim([-4 4]);
zlim([0 inf]);
hold on
scatter3(x0(1),x0(2),x0(3),'blue','filled');

[x31,fval31,iter31,t31] = proj3(x0,G3,c3,eps,n,d);
[x32,fval32,iter32,t32] = projquad(x0,G3,c3,a,0,eps,n,d);
[x33,fval33,iter33,t33] = projexpl(x0,G3,c3,a,0,eps,n,d);

x31 = x31';
fval31 = fval31';

fprintf('============================================================================================== \n');
fprintf(' Metoda striedavych projekcii - uhol pi/4\n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('  metoda  |  #iter.  |     x(1)      |     x(2)     |      x(3)     |    fval(k)   |    cas    \n');
fprintf('---------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f   | %4.10f |   %4.4f   \n' ,[iter31;x31(height(x31),:)';fval31(length(fval31));t31]);
fprintf('    QP    |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter32;x32(height(x32),:)';fval32(length(fval32));t32]);
fprintf('   EXPL.  |  %4.0f    |    %4.6f   |   %4.6f   |   %4.6f    | %4.10f |   %4.4f   \n' ,[iter33;x33(height(x33),:)';fval33(length(fval33));t33]);
fprintf('---------------------------------------------------------------------------------------------- \n');
