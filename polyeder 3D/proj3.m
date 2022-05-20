function [x_opt_vctr,fval,k,time] = proj3(x0,G,c,eps,n,d)

% pocet iteracii
k = 0;
% vektor optim. hodnot
fval = [0];
% vektor optim. rieseni
x_opt_vctr = x0;
% cas
time = 0;

for i=1:(n/2)
    cvx_precision high
    % projekcia na polyeder
    cvx_begin quiet
        variable x(d)
        minimize( norm(x0-x) )
        subject to
            G*x <= c
    cvx_end
    time = time + cvx_cputime;

    % vykreslenie
    hold on
    scatter3(x(1),x(2),x(3),'blue','filled');
    t = 0:0.2:1;
    plot3(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,x(3)+(x0(3)-x(3))*t,'Color','r','LineWidth',2);
    
    % vektor opt. rieseni a opt. hodot
    x_opt_vctr = [x_opt_vctr,x];
    fval = [fval;cvx_optval];

    % novy start. bod
    x0 = x;
    
    % projekcia na polpriestor
    cvx_begin quiet
         variable x(3)
         minimize( norm(x0-x) )
         subject to
            x(3) <= 0
    cvx_end
    time = time + cvx_cputime;

    % vykreslenie
    scatter3(x(1),x(2),x(3),'blue','filled');
    t = 0:0.2:1;
    plot3(x(1)+(x0(1)-x(1))*t,x(2)+(x0(2)-x(2))*t,x(3)+(x0(3)-x(3))*t,'Color','r','LineWidth',2);
    
    % vektor opt. rieseni a opt. hodot
    x_opt_vctr = [x_opt_vctr,x];
    fval = [fval;cvx_optval];

    % novy start. bod
    x0 = x;
    
    % pocet iteracii
    k = k+1;
    
    % zastavovacie kriterium
    if (cvx_optval^2<eps)
        break
    end    
    
end

time = time/8;
end