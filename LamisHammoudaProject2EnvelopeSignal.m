% BMME 385 Project 2 %
% Envolope Signal to find MAP & Blood Pressure %
% Lamis Hammouda %
% April 10th, 2023 %

% BEFORE RUNNING: %
% Change xlsread excel to the appropriate file %
% Install signal processing toolbox %

clear;clc
close all

%% Obtain the data from excel & plot it
data = xlsread("SubsetData.xlsx"); % [time, pressure, filteredPressure]
time = data(:,1);
pressure = data(:,2);
filteredPressure = data(:,3);
plot(time,filteredPressure)

%% Envelope
envelope(filteredPressure,20,'peaks') % Use envelope function to find envelope of the signal
[yupper, ylower] = envelope(filteredPressure,500);

% Calculate amplitude of the envelope
amplitude = abs(yupper - ylower);
[max, maxIndex] = max(amplitude);

%% MAP
MAP = pressure(maxIndex) % maximum amplitude of the envelope

%% Systolic & Diastolic

amplitudeSys = 0.55 * max;
amplitudeDia = 0.85 * max;

% Systolic 
distanceSys = abs(amplitudeSys - amplitude); % distance between each amplitude and the amplitude of systolic pressure
appendedSys = distanceSys(1:maxIndex);  % only search values before max for the systolic
[closestSys, closestSysIndex] = min(appendedSys); % find closest point
systolicPressure = pressure(closestSysIndex) % determine pressure at index of value closest to systolic amplitude

% Diastolic
amplitude(1:maxIndex) = zeros(); % replace all values before max with zero so they are not searched for diastolic
distanceDia = abs(amplitudeDia - amplitude);
[closestDia, closestDiaIndex] = min(distanceDia);
diastolicPressure = pressure(closestDiaIndex)