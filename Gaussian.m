% K�ch th??c c?a ma tr?n
rows = 10; % S? h�ng
cols = 10; % S? c?t

% T?o ma tr?n ng?u nhi�n theo ph�n ph?i Gaussian
M = rows * cols; % T?ng s? ph?n t?
sigma = 1 / sqrt(M); % ?? l?ch chu?n 
random_matrix = sigma * randn(rows, cols); % T?o ma tr?n ng?u nhi�n

% In ma tr?n ra m�n h�nh
disp(random_matrix);
