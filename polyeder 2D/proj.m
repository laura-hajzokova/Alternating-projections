function [x_opt,fval,iter,t] = proj(x0,M,b,N,c,eps,n,dim,col)

% pocet iteracii
iter = 0;

% vektor optim. hodnot
fval = [];

% vektor optim. rieseni
x_opt = [x0'];

% cas
t = 0; 

for i=1:n/2
    cvx_precision high
    cvx_begin quiet
    variable x(dim)
    minimize(norm(x0-x))
    subject to
        M*x <= b
    cvx_end

    t = t + cvx_cputime;
    x_opt = [x_opt;x'];
    fval = [fval;cvx_optval^2];
    
    % vykreslenie
    scatter(x(1),x(2),25,col,'filled');
    hold on
    k = 0:0.2:1;
    plot(x(1)+(x0(1)-x(1))*k,x(2)+(x0(2)-x(2))*k,'Color',col)
    
    % novy startovaci bod
    x0 = x;
    
    cvx_begin quiet
    variable x(dim) 
    minimize(norm(x0-x))
    subject to
        N*x <= c
    cvx_end

    t = t + cvx_cputime;
    x_opt = [x_opt;x'];
    fval = [fval;cvx_optval^2];
    
    % vykreslenie
    scatter(x(1),x(2),25,col,'filled');
    plot(x(1)+(x0(1)-x(1))*k,x(2)+(x0(2)-x(2))*k,'Color',col)
    
    % novy startovaci bod
    x0 = x;
    
    % zastavovacie kriterium
    iter = iter + 1;
    if (fval(2*i)<eps)
        break
    end 
end    

t = t/8;

end

