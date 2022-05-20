clc;
clear all;
close all;

% povodna matica
X0 = [4 3 0 2;
    3 4 3 0;
    0 3 4 3;
    2 0 3 4];

% pozicie matice A, kde nepozname hodnoty
s = [1, 3;
    2, 4;
    3, 1;
    4, 2];

% rozmer ulohy
n = length(diag(X0));

%toleracna konst.
eps = 1e-06;

% % VYKRESLENIE PRVEJ ITERACIE
% % prva projekcia na kuzel S^n_+ pomocou vl. hodnot
% [V,D] = eig(X0); 
% %V*D*inv(V);
% 
% for i=1:n
%     if (D(i,i)<0)
%         D(i,i) = 0;
%     end        
% end  
% 
% X = V*D*inv(V)
% k = s;
% % druha projekcia na afinny podpriestor sym. matic takych, ze TR(AiX)=bi
% for i=1:n
%     for j=1:n
%         if (i==k(1,1) && j==k(1,2))
%             Y(i,j) = X(i,j);
%         elseif (i==k(2,1) && j==k(2,2))
%             Y(i,j) = X(i,j);
%         elseif (i==k(3,1) && j==k(3,2))
%             Y(i,j) = X(i,j);
%         elseif (i==k(4,1) && j==k(4,2))
%             Y(i,j) = X(i,j);
%         else
%             Y(i,j) = 0;
%         end
%     end    
% end
% Y = Y + X0

[Xp,t,it] = proj_sdp(X0,s,n,eps)
