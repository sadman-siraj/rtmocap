clc; close all; clear all;

% Read the data and convert to N-by-3-by-M Matrix
data = RTMocap_read('subject1_file_11_data.txt');
% Read the time vector
time = dlmread('subject1_file_11_time.txt');

Fs = 100; % Sampling Frequency = 100 Hz

% Interpolate the data with the time vector
data_interpolated = RTMocap_interp(data, Fs, time);

% Smooth the data at 20hz
data_smoothed = RTMocap_smooth(data_interpolated, Fs, 20);

% Features: Acceleration (a), Velocity(v), and Jerk(j)
a = RTMocap_3Dacc(data_smoothed, Fs);
v = RTMocap_3Dvel(data_smoothed, Fs);
j = RTMocap_3Djerk(data_smoothed, Fs);

% Reshaping 3D to 2D
a = reshape(a, [size(a, 1) size(a, 3)]);
v = reshape(v, [size(v, 1) size(v, 3)]);
j = reshape(j, [size(j, 1) size(j, 3)]);

% Clipping Matrices to length of Jerk Matrix
a = a(1:size(j, 1), :);
v = v(1:size(j, 1), :);
j = j(1:size(j, 1), :);

% Features Matrix
f = [a v j];

% Save as csv file
csvwrite('subject1_file_11_features.csv', f)