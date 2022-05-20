function [xopt,optval,iter,t] = projexpl(x0,G,c,a,b,eps,n,dim)

xopt = x0';
optval = 0;
iter = 0;
ohr = length(G(:,1));

tic
for i=1:n

% projekcia na polyeder ako prienik polpriestorov
x00 = x0;
for j=1:ohr
    if (G(j,:)*x00 >= c(j))
        x = x00 + (c(j)-G(j,:)*x00)*G(j,:)'/(norm(G(j,:)',2)^2);
    else
        x = x00;
    end    
    x00 = x;
end
    
% optimalna hodnota (v ucelovej funkcii v quadprog zanedbavame konstantu)
fval = norm(x-x0)^2;
xopt = [xopt;x'];
optval = [optval;fval];

% vykreslenie projekcie 
hold on
scatter3(x(1),x(2),x(3),'blue','filled');
t = 0:0.2:1;
plot3(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,x(3)+(x0(3)-x(3))*t,'Color','r','LineWidth',2);

% novy startovaci bod
x0 = x;

% projekcie na polpriestor
x = x0 + (b-a'*x0)*a/(norm(a,2)^2);
% optimalna hodnota
fval = norm(x-x0)^2;
xopt = [xopt;x'];
optval = [optval;fval];

% vykreslenie projekcie 
scatter3(x(1),x(2),x(3),'blue','filled');
t = 0:0.2:1;
plot3(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,x(3)+(x0(3)-x(3))*t,'Color','r','LineWidth',2);

% pocet iteracii
iter = iter + 1;

% novy startovaci bod
x0 = x;

% zastavovacie kriterium
if (fval < eps)
    break
end
end
t = toc;


end

