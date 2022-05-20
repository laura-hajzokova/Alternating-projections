function [x] = calcvert(A,b)
x = [];
for i=1:length(A)
    if i ~= length(A)
        H = A(i:i+1,:);
        d = b(i:i+1);
        x = [x;(inv(H)*d)'];
    else
        H = [A(i,:);A(1,:)];
        d = [b(i);b(1)];
        x = [x;(inv(H)*d)'];
    end
end
end