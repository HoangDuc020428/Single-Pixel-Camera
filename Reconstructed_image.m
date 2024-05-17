clc
clear all
close all

% Load the image
original_image = imread('image_path');


% Display the original image
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

% Convert grayscale image to double data type
gray_image_double = double(gray_image);

noisy_gray_image = gray_image_double + noise;

% Create Bernoulli Matrix
num_matrices = matrix_size * 10;
bernoulli_matrices = zeros(matrix_size^2, num_matrices);
for i = 1:num_matrices
    bernoulli_matrices(:,i) = reshape(randi([0,1], matrix_size, matrix_size), [], 1);
end

noisy_gray_image_reshaped = noisy_gray_image(:); % Chuy?n noisy_gray_image thành vector c?t

Output = zeros(num_matrices, 1);
for i = 1:num_matrices
    Output(i) = sum(double(bernoulli_matrices(:, i)) .* double(noisy_gray_image_reshaped));
end

% Use CVX to reconstruct the original signal
cvx_begin
    variable xp(matrix_size^2) ;
    minimize(norm(xp,1));
    subject to
    for i = 1:num_matrices
        bernoulli_matrices(:,i)' * xp == Output(i);
    end
cvx_end

% Calculate the recovered signal
RecoveredImage = reshape(xp, matrix_size, matrix_size, []);



% Display all 3 images
figure;

subplot(1, 2, 1);
imagesc(original_image);
colormap gray;
title('Original Image');


subplot(1, 2, 2);
imagesc(RecoveredImage);
colormap gray;
title('Recovered Image');
% The number of pixels has a value of 0
num_zeros = sum(gray_image(:) == 0);
fprintf('The number of pixels has a value of 0: %d\n', num_zeros);

% Calculate the Mean Squared Error (MSE)
mse = sum((gray_image_double(:) - RecoveredImage(:)).^2) / numel(gray_image);
fprintf('Mean Squared Error (MSE): %.4f\n', mse);



