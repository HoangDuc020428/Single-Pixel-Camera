% Kích th???c cu?a ma trâ?n
rows = 10; % Sô? hàng
cols = 10; % Sô? cô?t
 
% Xác suâ?t thành công (1) trong phân phô?i Bernoulli
p = 0.5; 
 
% Ta?o ma trâ?n ngâ?u nhiên theo phân phô?i Bernoulli
random_matrix = rand(rows, cols) < p;
 
% In ma trâ?n ra màn h?nh
disp(random_matrix);
