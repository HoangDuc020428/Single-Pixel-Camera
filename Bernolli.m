% K�ch th???c cu?a ma tr�?n
rows = 10; % S�? h�ng
cols = 10; % S�? c�?t
 
% X�c su�?t th�nh c�ng (1) trong ph�n ph�?i Bernoulli
p = 0.5; 
 
% Ta?o ma tr�?n ng�?u nhi�n theo ph�n ph�?i Bernoulli
random_matrix = rand(rows, cols) < p;
 
% In ma tr�?n ra m�n h?nh
disp(random_matrix);
