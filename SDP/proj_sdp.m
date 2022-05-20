function [X,t,it] = proj_sdp(X,s,n,eps)

it = 0;

tic
for l=1:10000

    % prva projekcia na kuzel S^n_+ pomocou vl. hodnot
    [V,D] = eig(X); 
    %V*D*inv(V);

    for i=1:n
        if (D(i,i)<0)
            D(i,i) = 0;
        end        
    end  

    Y = V*D*inv(V);

    % druha projekcia na afinny podpriestor sym. matic takych, ze TR(AiX)=bi
    for i=1:n
        for j=1:n
            for k=1:length(s(:,1))
                if ((i==s(k,1)) && (j==s(k,2)))
      
                    X(i,j) = Y(i,j);
                end
            end    
        end
    end    

    if (norm(X-Y)<eps)
        break;
    end

    %X = Y;
    it = it +1;
end
t = toc;

end