% Kích th??c c?a ma tr?n
rows = 10; % S? hàng
cols = 10; % S? c?t

% T?o ma tr?n ng?u nhiên theo phân ph?i Gaussian
M = rows * cols; % T?ng s? ph?n t?
sigma = 1 / sqrt(M); % ?? l?ch chu?n 
random_matrix = sigma * randn(rows, cols); % T?o ma tr?n ng?u nhiên

% In ma tr?n ra màn hình
disp(random_matrix);
