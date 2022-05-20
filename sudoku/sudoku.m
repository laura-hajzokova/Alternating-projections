clc;
clear all;
close all;

% velkost sudoku
dim = 9;

% pocitadlo iteracii
iter_final = 0;

% vlozenie sudoku
opts = fixedWidthImportOptions('NumVariables',dim,'VariableWidths',ones(1,dim),'VariableTypes',{'double','double','double','double','double','double','double','double','double'});
%S_orig = readmatrix('easy_1.txt',opts);
%S_orig = readmatrix('medium_1.txt',opts);
S_orig = readmatrix(['hard_1.txt'],opts);

% pracovne sudoku - bude sa menit
S = S_orig;

% iteracie celkovo
iter_final = 0;

% tolerancna konstanta na sucet pravdepodobnosti (sucet 0.99 povazujeme za jednotku
epsilon = 0.99; 

%definovanie matice pravdepodobnosti - 3 rozmery
P = zeros(9,9,9);

%zadanie znamych prvkov
for i = 1:9
    for j = 1:9
        if S(i,j)~=0      
        P(i,j,S(i,j)) = 1;
        end
    end
end

% ukladanie povodnej P kvoli porovnavaniu
P_orig = P;

%pomocna premenna na kontrolu splnenych ohraniceni
kontrola_final = 0;
 
%iterujeme projekcie
tic;
while sum(sum(sum(P>=epsilon*ones(9,9,9)))) < 81 && iter_final < 1000 

% projekcia prveho typu (stlpcove ohranicenia)
for i = 1:9
    for j = 1:9
        P(:,i,j) = proj_simplex(squeeze(P(:,i,j))); % treba pouzit tvoju funkciu na projekciu + pre vyber vektora z 3D matice sa pouziva squeeze(P(:,i,j))
    end
end

% projekcia druheho typu (riadkove ohranicenia)
for i = 1:9
    for j = 1:9
        P(i,:,j) = proj_simplex(squeeze(P(i,:,j))')'; 
    end
end

% projekcia tretieho typu (aby v jednom policku neboli 2 hodnoty sucasne)
for i = 1:9
    for j = 1:9
        P(i,j,:) = proj_simplex(squeeze(P(i,j,:))); %analogicky zapis ohranicenia
    end
end

% projekcia stvrteho typu (ohranicenia na podmriezky)
for a = 1:3 
    for b = 1:3 
        for k = 1:9 
        P_proj = proj_simplex(vec(P(a*3-2:a*3,b*3-2:b*3,k))); 
        P(a*3-2:a*3,b*3-2:b*3,k) = [P_proj(1:3), P_proj(4:6), P_proj(7:9)]; 
        end
    end
end

% projekcia na polyeder (afinne ohranicenia pre zname prvky)
for i = 1:9
    for j = 1:9
        % znulovanie prvkov v stlpci, riadku, vyskovom stlpci a podmriezke
        if S(i,j) ~= 0
        P(:,j,S(i,j)) = zeros(9,1); 
        P(i,:,S(i,j)) = zeros(1,9);
        if i <= 3
            a = 3;
        elseif i <= 6
            a = 6;
        else 
            a = 9; 
        end
        if j <= 3
            b = 3;
        elseif j <= 6
            b = 6;
        else 
            b = 9; 
        end       
        P(a-2:a,b-2:b,S(i,j)) = zeros(3,3); 
        % pridanie jednotky na poziciu znameho prvku
        P(i,j,S(i,j)) = 1; 
        end
    end
end


%kontrola po skonceni iteracie, ci mame riesenie:
%ohranicenia prveho typu
for i = 1:9
    for j = 1:9
        sucet(i,j) = sum(P(:,i,j));
    end
end

if sum(sum(sucet >= epsilon*ones(9,9))) == 81
    kontrola1 = 1;
else
    kontrola1 = 0;
end

%ohranicenia druheho typu
for i = 1:9
    for j = 1:9
        sucet(i,j) = sum(P(i,:,j));
    end
end

if sum(sum(sucet >= epsilon*ones(9,9))) == 81 
    kontrola2 = 1;
else
    kontrola2 = 0;
end

%ohranicenia tretieho typu
for i = 1:9
    for j = 1:9
        sucet(i,j) = sum(P(i,j,:));
    end
end

if sum(sum(sucet >= epsilon*ones(9,9))) == 81
    kontrola3 = 1;
else
    kontrola3 = 0;
end

% afinne ohranicenia kontrolovat netreba - posledna projekcia v iteracii
kontrola4 = 1;

clc;
% pocitadlo iteracii
iter_final = iter_final + 1; 
% disp(iter_final) 

if kontrola1==1 && kontrola2==1 && kontrola3==1 && kontrola4==1 
    kontrola_final = 1;
    %break;
end

% najdenie najvacsej pravdepodobnosti
if kontrola_final == 1
    P_oprava = P;
    for i = 1:9
        for j = 1:9
            for k = 1:9
                if P_oprava(i,j,k) >= epsilon
                   % zmenime 1 na -1, aby sme dostali maximum zo zvysnych hodnot
                   P_oprava(i,j,k) = -P_oprava(i,j,k);
                end
            end
        end
    end
    [M,I] = max(P_oprava,[],"all","linear");
    [dim1, dim2, dim3] = ind2sub(size(P_oprava),I);
    % najdena pozicia a jej hodnota sa zada do S
    S(dim1, dim2) = dim3;
    %zmena sucasnej matice P 
    P(:,dim2,dim3) = zeros(9,1); 
    P(dim1,:,dim3) = zeros(1,9);
            if dim1 <= 3
                a = 3;
            elseif dim1 <= 6
                a = 6; 
            else 
                a = 9; 
            end
            if dim2 <= 3
                b = 3;
            elseif dim2 <= 6
                b = 6;
            else 
                b = 9; 
            end       
    P(a-2:a,b-2:b,S(dim1, dim2)) = zeros(3,3); 
    P(dim1, dim2, dim3) = 1;
end

end
time = toc;
clc
%celkovy pocet iteracii
disp(iter_final) 

% doplnenie S
S_final = S_orig;
for i = 1:9
    for j = 1:9
        if S_orig(i,j) == 0 && sum(squeeze(P(i,j,:)))~=0
           S_final(i,j) = find(P(i,j,:)>=epsilon); 
        end
    end
end
disp(S_final)