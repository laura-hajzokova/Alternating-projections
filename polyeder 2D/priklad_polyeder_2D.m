clc,
clear all;
close all;

% maximalny pocet iteracii
n = 100;

% dimenzia
dim = 2;

% toleracna konstanta
eps = 1e-8;

% ohranicenia na mnoziny M a N 
% Mx<=b
M =[-3 1;
    -2 1;
    -1 3;
    2 3;
    3 1;
    3 -2;
    1 -1;
    0 -1;
    -2 -1];
b = [0;0;15;33;32;35;13;7;5];

% Nx<=c
N =[5 3;
    1 3;
    -2 3;
    -5 1;
    -3 -2;
    1 -4;
    1 -1;
    3 1];
c = [0;12;30;49;32;22;4;0];

% vypocitanie krajnych bodov - kvoli obrazku
[vertM] = calcvert(M,b);
[vertN] = calcvert(N,c);

obrM = convhull(vertM);
obrN = convhull(vertN);

% vykreslenie mnozin
plot(vertM(:,1),vertM(:,2),'.k')
hold on
plot(vertM(obrM,1),vertM(obrM,2),'-k')
plot(vertN(:,1),vertN(:,2),'.k')
plot(vertN(obrN,1),vertN(obrN,2),'-k')
xlim([-10 11])


%startovaci bod
x01 = [-1; 8];
scatter(x01(1),x01(2),25,'red','filled')
[x_opt11,fval11,iter11,t11] = proj(x01,M,b,N,c,eps,n,dim,'red');
[x_opt13,fval13,iter13,t13] = proj2(x01,M,b,N,c,eps,n,dim,'blue');

% startovaci bod
x02 = [-5; 5];
scatter(x02(1),x02(2),25,'blue','filled')
[x_opt21,fval21,iter21,t21] = proj(x02,M,b,N,c,eps,n,dim,'blue');
[x_opt23,fval23,iter23,t23] = proj2(x02,M,b,N,c,eps,n,dim,'blue');

x03 = [2; -10];
scatter(x03(1),x03(2),25,[0.7020,0.2863,0.9608],'filled')
[x_opt31,fval31,iter31,t31] = proj(x03,M,b,N,c,eps,n,dim,[0.7020,0.2863,0.9608]);
[x_opt33,fval33,iter33,t33] = proj2(x03,M,b,N,c,eps,n,dim,[0.7020,0.2863,0.9608]);

x04 = [5; -1];
scatter(x04(1),x04(2),25,[0.3490,0.7804,0.0392],'filled')
[x_opt41,fval41,iter41,t41] = proj(x04,M,b,N,c,eps,n,dim,[0.3490,0.7804,0.0392]);
[x_opt43,fval43,iter43,t43] = proj2(x04,M,b,N,c,eps,n,dim,[0.3490,0.7804,0.0392]);

x05 = [-4; -9];
scatter(x05(1),x05(2),25,[1.0000,0.0745,0.6510],'filled')
[x_opt51,fval51,iter51,t51] = proj(x05,M,b,N,c,eps,n,dim,[1.0000,0.0745,0.6510]);
[x_opt53,fval53,iter53,t53] = proj2(x05,M,b,N,c,eps,n,dim,[1.0000,0.0745,0.6510]);

fprintf('==================================================================================================== \n');
fprintf(' Metoda striedavych projekcii \n');
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('  metoda  |  #iter.  |    x0(1)   |   x0(2)   |     x(1)     |    x(2)    |   fval(k)  |    cas    \n');
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.2f   |    %4.2f   |    %6.4f   |   %6.4f   | %10.8f |   %6.4f   \n' ,[iter11;x01;x_opt11(height(x_opt11),:)';fval11(length(fval11));t11]);
fprintf('    QP    |  %4.0f    |    %4.2f   |    %4.2f   |    %6.4f   |   %6.4f   | %10.8f |   %6.4f   \n' ,[iter13;x01;x_opt13(height(x_opt13),:)';fval13(length(fval13));t13]);
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.2f   |    %4.2f   |    %6.4f   |   %6.4f   | %10.8f |   %6.4f   \n' ,[iter21;x02;x_opt21(height(x_opt21),:)';fval21(length(fval21));t21]);
fprintf('    QP    |  %4.0f    |    %4.2f   |    %4.2f   |    %6.4f   |   %6.4f   | %10.8f |   %6.4f   \n' ,[iter23;x02;x_opt23(height(x_opt23),:)';fval23(length(fval23));t23]);
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.2f    |   %4.2f  |    %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter31;x03;x_opt31(height(x_opt31),:)';fval31(length(fval31));t31]);
fprintf('    QP    |  %4.0f    |    %4.2f    |   %4.2f  |    %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter33;x03;x_opt33(height(x_opt33),:)';fval33(length(fval33));t33]);
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.2f    |   %4.2f   |     %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter41;x04;x_opt41(height(x_opt41),:)';fval41(length(fval41));t41]);
fprintf('    QP    |  %4.0f    |    %4.2f    |   %4.2f   |     %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter43;x04;x_opt43(height(x_opt43),:)';fval43(length(fval43));t43]);
fprintf('---------------------------------------------------------------------------------------------------- \n');
fprintf('    CVX   |  %4.0f    |    %4.2f   |   %4.2f   |    %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter51;x05;x_opt51(height(x_opt51),:)';fval51(length(fval51));t51]);
fprintf('    QP    |  %4.0f    |    %4.2f   |   %4.2f   |    %6.4f   |  %6.4f   | %10.8f |   %6.4f   \n' ,[iter53;x05;x_opt53(height(x_opt53),:)';fval53(length(fval53));t53]);
fprintf('---------------------------------------------------------------------------------------------------- \n');