% Clear junk variables
clear all;
clc;

% Close other frames
close all;

% Initilize needed variables
primaryColor = '#f2b085'; secondaryColor = '#85c7f2';

% Set up all needed frames
mainFrame = figure('position', [0 0 700 500], 'Name', 'Coffe Machine', 'NumberTitle', 'off');
titleFrame = axes('position', [0 .85 1 .15], 'color', secondaryColor, 'xtick', [], 'ytick', [], 'xlim', [0, 1], 'ylim', [0, 1]);
leftHalf = axes('position', [0 0 .5 .85], 'color', 'white', 'xtick', [], 'ytick', [], 'xlim', [0, 1], 'ylim', [0, 1]);
rightHand = axes('position', [0.5 0 .5 .85], 'color', 'white', 'xtick', [], 'ytick', [], 'xlim', [0, 1], 'ylim', [0, 1]);
