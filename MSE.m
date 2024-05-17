clc
clear all
close all

% Load the image
original_image = imread('image_path');

% Convert RGB image to grayscale
if size(original_image, 3) == 3
    gray_image = uint8(0.2989 * original_image(:,:,1) + 0.5870 * original_image(:,:,2) + 0.1140 * original_image(:,:,3));
else
    gray_image = original_image;
end

% Define the matrix size
[matrix_size, ~, ~] = size(original_image);

% Add Gaussian noise to the original image
noise_level = 1;
noise = noise_level * randn(size(gray_image));
gray_image_double = double(gray_image);
noisy_gray_image = gray_image_double + noise;

% Initialize arrays to store MSE values and number of matrices
mse_values = []; % MSE values
num_matrices_values = []; % Number of Bernoulli matrices

% Create Bernoulli Matrices
step_size = 64;
num_matrices_total = matrix_size^2;
num_loops = num_matrices_total / step_size;

for i = 1:num_loops
    num_matrices = i * step_size;
    num_matrices_values(end+1) = num_matrices; % Store the current number of matrices
    
    bernoulli_matrices = zeros(matrix_size^2, num_matrices);
    for j = 1:num_matrices
        bernoulli_matrices(:,j) = reshape(randi([0,1], matrix_size, matrix_size), [], 1);
    end

    noisy_gray_image_reshaped = noisy_gray_image(:); 
    Output = zeros(num_matrices, 1);
    for j = 1:num_matrices
        Output(j) = sum(double(bernoulli_matrices(:, j)) .* double(noisy_gray_image_reshaped));
    end

    cvx_begin quiet
        variable xp(matrix_size^2) ;
        minimize(norm(xp,1));
        subject to
        for j = 1:num_matrices
            bernoulli_matrices(:,j)' * xp == Output(j);
        end
    cvx_end

    RecoveredImage = reshape(xp, matrix_size, matrix_size);
    
    % Calculate MSE and store it
    mse = sum(sum((gray_image_double - RecoveredImage).^2)) / numel(gray_image);
    mse_values(end+1) = mse;
end

% Plot and save MSE
figure;
plot(num_matrices_values, mse_values);
xlabel('Number of Bernoulli Matrices');
ylabel('MSE');
title('MSE vs. Number of Bernoulli Matrices');

while true
    num_matrices_input = input('Enter the number of Bernoulli matrices: ');

    [~, idx] = min(abs(num_matrices_values - num_matrices_input));

    mse_for_input = mse_values(idx);

    fprintf('MSE for %d Bernoulli matrices: %.4f\n', num_matrices_input, mse_for_input);

    answer = input('Do you want to enter another value? (yes/no): ', 's');
    if ~strcmpi(answer, 'yes')
        break;
    end
end

