function [xopt,optval,iter,t] = proj2(x0,A,b,C,d,eps,n,dim,col)

xopt = x0';
optval = [];
iter = 0;

tic
for i=1:n

% projekcia ma polyeder
x = quadprog(2*eye(dim),-2*x0,A,b);
% optimalna hodnota (v ucelovej funkcii v quadprog zanedbavame konstantu)
fval = norm(x-x0)^2;
xopt = [xopt;x'];
optval = [optval;fval];

% % vykreslenie projekcie 
% hold on
% scatter(x(1),x(2),25,col,'filled');
% t = 0:0.2:1;
% plot(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,'Color',col);
% 
% novy startovaci bod
x0 = x;

% projekcia ma polyeder
x = quadprog(2*eye(dim),-2*x0,C,d);
% optimalna hodnota (v ucelovej funkcii v quadprog zanedbavame konstantu)
fval = norm(x-x0)^2;
xopt = [xopt;x'];
optval = [optval;fval];

% % vykreslenie projekcie 
% scatter(x(1),x(2),25,col,'filled');
% t = 0:0.2:1;
% plot(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,'Color',col);

% pocet iteracii
iter = iter +1;

x0 = x;

if (optval(2*i) < eps)
    break
end
end
t = toc;

end