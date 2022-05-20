function [x] = proj_simplex(x0)

dim = length(x0);

o = ones(dim,1);
g = @(lambda) -(.5*norm(max(x0-lambda*o,0)-(x0-lambda*o))^2 + lambda*(o'*x0-1) - 0.5*dim*lambda^2);
[lambda_opt,g_opt] = fminsearch(g,0);

x = max(x0 - lambda_opt(end)*o,0);

end