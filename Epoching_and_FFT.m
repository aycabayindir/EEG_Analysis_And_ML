clear all 
close all

eeglab

%% Load data
[EEG,h]=pop_loadbv('C:\Users\ayca\Desktop','file_name.ahdr');


%% Getting the The Conjugate Transpose of EEG Data to perform Epoching

b=EEG.data
b=b'

%b(x:y,:) x=start, y = end
EEG.data = b (471921:532601,:) %Cropping the intervall for corresponding event 

%% Fast Fourier Transformation (FFT)

% Getting Absolute Value of EEG data
load("Left_Data\l2_2.mat")
abs_data = abs(l2_2)

%FFT
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector

%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L

P2 = abs(Y/L);
Z = L/2+1
P1 = P2(1:Z);
P1(2:end-1) = 2*P1(2:end-1);

%Define the frequency domain f  
f = Fs*(0:(L/2))/L; 

%the Fourier transform of the original, uncorrupted signal 
Y = fft(abs_data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f,P1) 
title("Single-Sided Amplitude Spectrum of EEG Sample")
xlabel("f (Hz)")
ylabel("|P1(f)|")