% size of the matrix
rows = 10; 
cols = 10;

M = rows * cols; 
sigma = 1 / sqrt(M); 
random_matrix = sigma * randn(rows, cols); 

disp(random_matrix);
